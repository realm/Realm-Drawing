//
//  ToolBarView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 24/12/2021.
//

import SwiftUI
import RealmSwift

struct ToolBarView: View {
    @ObservedRealmObject var drawing: Drawing
    @Binding var color: Color
    @Binding var lineWidth: CGFloat
    
    var body: some View {
        HStack {
            BrushView(color: $color, lineWidth: $lineWidth)
            Spacer()
            Button {
                let lastIndex = drawing.lines.count - 1
                if lastIndex >= 0 {
                    $drawing.lines.remove(at: lastIndex)
                }
            } label: {
                Image(systemName: "arrow.uturn.backward.circle")
                    .imageScale(.large)
            }
            .disabled(drawing.lines.count == 0)
        }
        .padding()
        .frame(maxHeight: 100)
    }
}

struct ToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolBarView(drawing: Drawing(), color: .constant(.orange), lineWidth: .constant(15))
    }
}
