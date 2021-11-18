//
//  PersistableColor.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import RealmSwift
import SwiftUI

class PersistableColor: EmbeddedObject {
    @Persisted var red: Double = 0
    @Persisted var green: Double = 0
    @Persisted var blue: Double = 0
    @Persisted var opacity: Double = 0
    
    convenience init(color: Color) {
        self.init()
        if let components = color.cgColor?.components {
            if components.count >= 3 {
                red = components[0]
                green = components[1]
                blue = components[2]
            }
            if components.count >= 4 {
                opacity = components[3]
            }
        }
    }
    
    var color: Color {
        Color(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
