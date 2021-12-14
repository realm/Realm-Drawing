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
    
    let engine = DrawingEngine()
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Canvas { context, size in
                    for line in drawing.lines {
                        let path = engine.createPath(for: line.linePoints.map { point in
                            CGPoint(x: point.x * geometry.size.width, y: point.y * geometry.size.height)
                        })
                        context.stroke(path, with: .color(line.color), style: StrokeStyle(lineWidth: line.lineWidth, lineCap: .round, lineJoin: .round))
                    }
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({ value in
                    let newPoint = PersistablePoint(x: value.location.x / geometry.size.width, y: value.location.y / geometry.size.height)
                    if value.translation.width + value.translation.height == 0 {
                        $drawing.lines.append(Line(point: newPoint, color: selectedColor, lineWidth: selectedLineWidth))
                    } else {
                        let index = drawing.lines.count - 1
                        $drawing.lines[index].linePoints.append(newPoint)
                    }
                })
                            .onEnded({ value in
                    if let last = drawing.lines.last?.linePoints, last.isEmpty {
                        $drawing.lines.wrappedValue.removeLast()
                    }
                })
                )
            }
            HStack {
                BrushView(color: $selectedColor, lineWidth: $selectedLineWidth)
                Spacer()
                Button {
                    let lastIndex = drawing.lines.count - 1
                    if lastIndex >= 0 {
                        $drawing.lines.remove(at: lastIndex)
                    }
                } label: {
                    Image(systemName: "arrow.uturn.backward.circle")
                        .imageScale(.large)
                }
                .disabled(drawing.lines.count == 0)
            }
            .padding()
            .frame(maxHeight: 100)
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
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DrawingView(drawing: Drawing())
        }
    }
}
