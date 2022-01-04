//
//  InProgressLineView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 04/01/2022.
//

import SwiftUI
import RealmSwift

struct InProgressLineView: View {
    @ObservedRealmObject var drawing: Drawing
    let color: Color
    let lineWidth: CGFloat
    let engine: DrawingEngine
    let geoSize: CGSize
    
    @State private var currentPoints = [CGPoint]()
    
    var body: some View {
        Canvas { context, size in
            let path = engine.createPath(for: currentPoints)
            context.stroke(path, with: .color(color), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
        }
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ value in
            positionChanged(location: value.location,
                            translation: value.translation,
                            width: geoSize.width,
                            height: geoSize.height)
        })
                    .onEnded({ _ in
            lineEnded(width: geoSize.width, height: geoSize.height)
        })
        )
    }
    
    private func positionChanged(location: CGPoint, translation: CGSize, width: Double, height: Double) {
        if translation.width + translation.height == 0 {
            currentPoints = [CGPoint]()
        }
        currentPoints.append(location)
    }
    
    private func lineEnded(width: Double, height: Double) {
        if !currentPoints.isEmpty {
            $drawing.lines.append(Line(points: currentPoints, color: color, lineWidth: lineWidth, xScale: width, yScale: height))
        }
        currentPoints = [CGPoint]()
    }
}
