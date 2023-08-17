//
//  DrawingName.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 17/08/2023.
//

import Foundation
import SwiftUI
import RealmSwift

class DrawingName: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var author: String
    @Persisted var name: String
    
    convenience init(author: String, name: String) {
        self.init()
        self.author = author
        self.name = name
    }
}
