//
//  Line.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import Foundation
import RealmSwift
import SwiftUI

extension CGFloat: CustomPersistable {
    public typealias PersistedType = Double
    public init(persistedValue: Double) {
        self = persistedValue
    }
    public var persistableValue: Double {
        self
    }
}

class Line: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var color: Color
    @Persisted var width: CGFloat = 5.0
    @Persisted var points = RealmSwift.List<CGPoint>()
}

extension Line {
    convenience init(color: Color, lineWidth: CGFloat) {
        self.init()
        self.color = color
        self.width = lineWidth
    }
}
