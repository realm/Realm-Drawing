//
//  ContentView.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import SwiftUI

struct ContentView: View {
    @State var username = ""
    
    var body: some View {
        NavigationView {
            Group {
                if username == "" {
                    LoginView(username: $username)
                } else {
                    DrawingPickerView(username: username)
                        .environment(\.realmConfiguration, realmApp.currentUser!.configuration(partitionValue: "user=\(username)"))
                        .navigationBarItems(leading: realmApp.currentUser != nil ? LogoutButton(username: $username) : nil)
                }
            }
        }
        .currentDeviceNavigationViewStyle(alwaysStacked: true)
    }
}

extension View {
    public func currentDeviceNavigationViewStyle(alwaysStacked: Bool) -> AnyView {
        return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
