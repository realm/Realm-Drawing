//
//  DrawingWrapperView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 17/08/2023.
//

import SwiftUI
import RealmSwift

struct DrawingWrapperView: View {
    @ObservedResults(Drawing.self) var drawings
    @Environment(\.realm) var realm
    
    let drawingName: DrawingName
    
    var body: some View {
        Group {
            if let drawing = drawings.first {
                DrawingView(drawing: drawing)
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: setSubscriptions)
        .onDisappear(perform: clearSubscriptions)
    }
    
    private func setSubscriptions() {
        let subscriptions = realm.subscriptions
        if subscriptions.first(named: "drawings-\(drawingName.author)-\(drawingName.name)") == nil {
            subscriptions.update() {
                subscriptions.append(QuerySubscription<Drawing>(name: "drawings") { drawing in
                    drawing.author == drawingName.author && drawing.name == drawingName.name
                })
            }
        }
    }
    
    private func clearSubscriptions() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            subscriptions.remove(named: "drawings")
        } onComplete: { error in
            if let error = error {
                print("Failed to unsubscribe for drawings: \(error.localizedDescription)")
            }
        }
    }
}

struct DrawingWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingWrapperView(drawingName: DrawingName(author: "Andrew", name: "Fish"))
    }
}
