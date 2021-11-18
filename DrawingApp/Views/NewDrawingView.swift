//
//  NewDrawingView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import SwiftUI
import RealmSwift

struct NewDrawingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedResults(Drawing.self) var drawings
    
    @State private var drawingName = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Spacer()
                TextField("Drawing name", text: $drawingName)
                Button(action: newDrawing) {
                    Text("Add drawing")
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(drawingName.count == 0)
                Spacer()
            }
            .padding()
            .navigationBarTitle("New Drawing", displayMode: .inline)
        }
        .currentDeviceNavigationViewStyle(alwaysStacked: true)
    }
    
    private func newDrawing() {
        $drawings.append(Drawing(drawingName))
        presentationMode.wrappedValue.dismiss()
    }
}

struct NewDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        NewDrawingView()
    }
}
