////
////  PersistablePoint.swift
////  DrawingApp
////
////  Created by Andrew Morgan on 18/11/2021.
////
//
//import SwiftUI
//import RealmSwift
//
//class PersistablePoint: EmbeddedObject, ObjectKeyIdentifiable {
//    @Persisted var x = 0.0
//    @Persisted var y = 0.0
//    
//    convenience init(_ point: CGPoint) {
//        self.init()
//        self.point = point
//    }
//    
//    convenience init(x: Double, y: Double) {
//        self.init()
//        self.x = x
//        self.y = y
//    }
//    
//    var point: CGPoint {
//        get {
//            CGPoint(x: x, y: y)
//        }
//        set {
//            x = Double(newValue.x)
//            y = Double(newValue.y)
//        }
//    }
//}
