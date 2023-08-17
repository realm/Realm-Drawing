//
//  DrawingPickerView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import SwiftUI
import RealmSwift

struct DrawingPickerView: View {
    @ObservedResults(Drawing.self) var drawings
    
    let username: String
    
    @State private var showingNewDrawing = false
    
    var body: some View {
        ZStack {
            List {
                ForEach(drawings) { drawing in
                    HStack {
                        NavigationLink(destination: DrawingView(drawing: drawing)) {
                            Text(drawing.name)
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
        }
        .sheet(isPresented: $showingNewDrawing) {
            NewDrawingView()
                .environment(\.realmConfiguration, realmApp.currentUser!.configuration(partitionValue: "user=\(username)"))
        }
        .navigationBarTitle("\(username)'s Drawings", displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { showingNewDrawing.toggle() }) {
                    Image(systemName: "plus")
                }
            }
        }
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
