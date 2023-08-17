//
//  DrawingView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import SwiftUI
import RealmSwift

struct DrawingView: View {
    @ObservedRealmObject var drawing: Drawing
    
    @State private var selectedColor: Color = .black
    @State private var selectedLineWidth: CGFloat = 1
    @State private var currentPoints = [CGPoint]()
    
    let engine = DrawingEngine()
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Canvas { context, size in
                        for line in drawing.lines {
                            let path = engine.createPath(for: line.linePoints.map { point in
                                CGPoint(x: point.x * geometry.size.width, y: point.y * geometry.size.height)
                            })
                            context.stroke(path, with: .color(line.lineColor), style: StrokeStyle(lineWidth: line.lineWidth, lineCap: .round, lineJoin: .round))
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onChanged({ value in
                        positionChanged(location: value.location,
                                        translation: value.translation,
                                        width: geometry.size.width,
                                        height: geometry.size.height)
                    })
                                .onEnded({ _ in
                        lineEnded(width: geometry.size.width, height: geometry.size.height)
                    })
                    )
                }
            }
            ToolBarView(drawing: drawing, color: $selectedColor, lineWidth: $selectedLineWidth)
        }
        .background(.white)
        .navigationBarTitle("\(drawing.name)", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { showConfirmation = true }) {
            Image(systemName: "trash")
        }
        .foregroundColor(.red)
        .confirmationDialog(Text("Are you sure you want to delete everything?"), isPresented: $showConfirmation) {
            Button("Clear", role: .destructive) {
                $drawing.lines.remove(atOffsets: IndexSet(integersIn: 0..<drawing.lines.count))
            }
            Button("Cancel", role: .cancel) {}
        })
    }
    
    private func positionChanged(location: CGPoint, translation: CGSize, width: Double, height: Double) {
        let newPoint = CGPoint(x: location.x / width, y: location.y / height)
        if translation.width + translation.height == 0 {
            $drawing.lines.append(Line(point: newPoint, color: selectedColor, lineWidth: selectedLineWidth))
        } else {
            let index = drawing.lines.count - 1
            $drawing.lines[index].linePoints.append(newPoint)
        }
    }
    
    private func lineEnded(width: Double, height: Double) {
        if let last = drawing.lines.last?.linePoints, last.isEmpty {
            $drawing.lines.wrappedValue.removeLast()
        }
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DrawingView(drawing: Drawing())
        }
        .currentDeviceNavigationViewStyle(alwaysStacked: true)
    }
}
