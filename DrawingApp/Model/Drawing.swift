//
//  Drawing.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import Foundation
import RealmSwift

class Drawing: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = UUID().uuidString
    @Persisted var lines: List<Line>
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
    
    func clear() {
        lines.removeAll()
    }
}
