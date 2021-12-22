//
//  PersistablePoint.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import CoreGraphics
import RealmSwift

extension CGPoint: CustomPersistable {
    public typealias PersistedType = PersistablePoint
    public init(persistedValue: PersistablePoint) {
        self.init(x: persistedValue.x, y: persistedValue.y)
    }
    public var persistableValue: PersistablePoint {
        return PersistablePoint(x: x, y: y)
    }
}

public class PersistablePoint: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var x = 0.0
    @Persisted var y = 0.0

    convenience init(x: Double, y: Double) {
        self.init()
        self.x = x
        self.y = y
    }
}
