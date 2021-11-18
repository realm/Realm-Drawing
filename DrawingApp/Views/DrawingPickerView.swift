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
    
    @State private var isWaiting = true
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
            if isWaiting {
                ProgressView()
            }
        }
        .onAppear(perform: waitABit)
        .sheet(isPresented: $showingNewDrawing) {
            NewDrawingView()
                .environment(\.realmConfiguration, realmApp.currentUser!.configuration(partitionValue: "user=\(username)"))
        }
        .navigationBarTitle("\(username)'s Drawings", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { showingNewDrawing.toggle() }) {
            Image(systemName: "plus")
        })
    }
    
    private func waitABit() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isWaiting = false
        }
    }
}

struct DrawingPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DrawingPickerView(username: "Andrew")
        }
    }
}
