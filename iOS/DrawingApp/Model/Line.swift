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
    @Persisted var lineColor: Color
    @Persisted var lineWidth: CGFloat = 5.0
    @Persisted var linePoints = RealmSwift.List<CGPoint>()
}

extension Line {
   
    convenience init (point: CGPoint, color: Color, lineWidth: CGFloat) {
        self.init()
        self.linePoints.append(point)
        self.lineColor = color
        self.lineWidth = lineWidth
    }
    
    convenience init (points: RealmSwift.List<CGPoint>, color: Color, lineWidth: CGFloat, xScale: CGFloat, yScale: CGFloat) {
        self.init()
        self.linePoints = points
        self.lineColor = color
        self.lineWidth = lineWidth
    }
}

extension CGFloat: CustomPersistable {
    public typealias PersistedType = Double
    public init(persistedValue: Double) { self.init(persistedValue) }
    public var persistableValue: Double { Double(self) }
}
