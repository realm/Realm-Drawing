//
//  Line.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import Foundation
import SwiftUI
import RealmSwift

class Line: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var lineColor: PersistableColor?
    @Persisted var lineWidth = 5.0
    @Persisted var x = RealmSwift.List<Double>()
    @Persisted var y = RealmSwift.List<Double>()
//    @Persisted var linePoints = RealmSwift.List<PersistablePoint>()
    
}

extension Line {
    var points: [CGPoint] {
        var points = [CGPoint]()
        if x.count != y.count {
            print("x has \(x.count) elements, y has \(y.count)")
            return points
        }
        for index in 0...x.count - 1 {
            points.append(CGPoint(x: x[index], y: y[index]))
        }
        return points
    }
    
    func scaledPoints(xScale: Double, yScale: Double) -> [CGPoint] {
        var points = [CGPoint]()
        if x.count != y.count {
            print("x has \(x.count) elements, y has \(y.count)")
            return points
        }
        for index in 0...x.count - 1 {
            points.append(CGPoint(x: x[index] * xScale, y: y[index] * yScale))
        }
        return points
    }
//    var points: [CGPoint] {
//        linePoints.map { point in
//            point.point
//        }
//    }
    
    var color: Color {
        get {
            lineColor?.color ?? .black
        }
        set {
            lineColor = PersistableColor(color: newValue)
        }
    }
    
    var width: CGFloat {
        get {
            CGFloat(lineWidth)
        }
        set {
            lineWidth = Double(newValue)
        }
    }
    
    convenience init (x: Double, y: Double, color: Color, lineWidth: CGFloat) {
        self.init()
        self.x.append(x)
        self.y.append(y)
//        self.linePoints.append(point)
        self.color = color
        self.width = lineWidth
    }
}
