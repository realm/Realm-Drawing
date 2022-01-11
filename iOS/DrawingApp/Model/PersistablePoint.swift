//
//  PersistablePoint.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import SwiftUI
import RealmSwift

public class PersistablePoint: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var x = 0.0
    @Persisted var y = 0.0
    
    convenience init(_ point: CGPoint) {
        self.init()
        self.x = point.x
        self.y = point.y
    }
}

extension CGPoint: CustomPersistable {
    public typealias PersistedType = PersistablePoint
    
    public init(persistedValue: PersistablePoint) { self.init(x: persistedValue.x, y: persistedValue.y) }
    
    public var persistableValue: PersistablePoint { PersistablePoint(self) }
}
