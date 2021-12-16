//
//  DrawingView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import SwiftUI
import RealmSwift

func * (left: CGPoint, right: CGSize) -> CGPoint {
    return CGPoint(x: left.x * right.width, y: left.y * right.height)
}
func / (left: CGPoint, right: CGSize) -> CGPoint {
    return CGPoint(x: left.x / right.width, y: left.y / right.height)
}

struct DrawingView: View {
    @AppStorage("delayPersistance") var delayPersistance = false
    @ObservedRealmObject var drawing: Drawing
    
    @State private var selectedColor: Color = .black
    @State private var selectedLineWidth: CGFloat = 1
    @State private var currentLine = Line()
    @StateRealmObject private var unmanagedLine = Line()

    let engine = DrawingEngine()
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Canvas { context, size in
                    for line in drawing.lines {
                        drawLine(context: context, size: geometry.size, line: line)
                    }
                    drawLine(context: context, size: geometry.size, line: unmanagedLine)
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({ value in
                    positionChanged(location: value.location / geometry.size,
                                    translation: value.translation)
                })
                            .onEnded { _ in lineEnded() })
            }
            // TODO: Move to a new View
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

    private func drawLine(context: GraphicsContext, size: CGSize, line: Line) {
        guard !line.points.isEmpty else { return }
        let path = engine.createPath(for: line.points.map { $0 * size })
        context.stroke(path, with: .color(line.color),
                       style: StrokeStyle(lineWidth: line.width, lineCap: .round, lineJoin: .round))
    }
    
    private func positionChanged(location newPoint: CGPoint, translation: CGSize) {
        if translation == CGSize(width: 0, height: 0) {
            if delayPersistance {
                unmanagedLine.color = selectedColor
                unmanagedLine.width = selectedLineWidth
                currentLine = unmanagedLine
            } else {
                currentLine = Line(color: selectedColor, lineWidth: selectedLineWidth)
                $drawing.lines.append(currentLine)
            }
        }
        currentLine.realm?.beginWrite()
        currentLine.points.append(newPoint)
        try! currentLine.realm?.commitWrite()
    }
    
    private func lineEnded() {
        if delayPersistance {
            if !currentLine.points.isEmpty {
                $drawing.lines.append(Line(value: currentLine))
            }
            currentLine.points.removeAll()
        } else {
            if currentLine.points.isEmpty {
                $drawing.lines.wrappedValue.removeLast()
            }
        }
        currentLine = Line()
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DrawingView(drawing: Drawing())
        }
    }
}
