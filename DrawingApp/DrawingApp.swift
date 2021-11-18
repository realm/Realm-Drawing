//
//  DrawingApp.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import SwiftUI
import RealmSwift

let realmApp = RealmSwift.App(id: "draw-obtsw")

@main
struct DrawingAppApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
