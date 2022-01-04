//
//  BrushView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import SwiftUI

struct BrushView: View {
    @Binding var color: Color
    @Binding var lineWidth: CGFloat
    
    var body: some View {
        HStack {
            ColorPicker("line color", selection: $color)
                .labelsHidden()
            Slider(value: $lineWidth, in: 1...50) {
                Text("line width")
            }.frame(maxWidth: 100)
            Text(String(format: "%.0f", lineWidth))
                .foregroundColor(.black)
            Circle()
                .foregroundColor(color)
                .frame(width: lineWidth)
        }
    }
}

struct BrushView_Previews: PreviewProvider {
    static var previews: some View {
        BrushView(color: .constant(.pink), lineWidth: .constant(50))
    }
}
