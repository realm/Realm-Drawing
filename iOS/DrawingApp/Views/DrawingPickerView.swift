//
//  DrawingPickerView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import SwiftUI
import RealmSwift

struct DrawingPickerView: View {
    @ObservedResults(DrawingName.self) var drawings
    @Environment(\.realm) var realm
    
    @State private var inProgress = false
    
    let username: String
    
    @State private var showingNewDrawing = false
    
    var body: some View {
        ZStack {
            List {
                ForEach(drawings) { drawing in
                    HStack {
                        if let currentUser = realmApp.currentUser {
                            NavigationLink(destination: DrawingWrapperView(drawingName: drawing)
                            .environment(\.realmConfiguration,
                                          currentUser.flexibleSyncConfiguration())) {
                                Text(drawing.name)
                            }
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive, action: {
                            $drawings.remove(drawing)
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            if inProgress {
                ProgressView()
            }
        }
        .sheet(isPresented: $showingNewDrawing) {
            NewDrawingView(addDrawing: addDrawing)
        }
        .navigationBarTitle("\(username)'s Drawings", displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { showingNewDrawing.toggle() }) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear(perform: setSubscriptions)
    }
    
    private func setSubscriptions() {
        let subscriptions = realm.subscriptions
        if subscriptions.first(named: "drawingNames") == nil {
            inProgress = true
            subscriptions.update() {
            subscriptions.append(QuerySubscription<DrawingName>(name: "drawingNames") { drawing in
                drawing.author == username
            })
            } onComplete: { _ in
                Task { @MainActor in
                    inProgress = false
                }
            }
        }
    }
    
    private func addDrawing(name: String) {
        let drawing = DrawingName(author: username, name: name)
        $drawings.append(drawing)
    }
}

struct DrawingPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DrawingPickerView(username: "Andrew")
        }
        .currentDeviceNavigationViewStyle(alwaysStacked: true)
    }
}
