//
//  SettingsView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 14/12/2021.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("delayPersistance") var delayPersistance = false
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Form {
            Section("Performance") {
                Toggle(isOn: $delayPersistance, label: {
                    Text("Delay persisting line-points until pencil lifted")
                })
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}
