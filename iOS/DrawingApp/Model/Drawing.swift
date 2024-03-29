//
//  Drawing.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import Foundation
import SwiftUI
import RealmSwift

class Drawing: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var author: String
    @Persisted var name: String
    @Persisted var lines = RealmSwift.List<Line>()
    
    convenience init(author: String, name: String) {
        self.init()
        self.author = author
        self.name = name
    }
    
    func clear() {
        lines = RealmSwift.List<Line>()
    }
}
