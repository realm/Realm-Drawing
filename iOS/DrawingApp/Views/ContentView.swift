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
        NavigationStack {
            if username == "" {
                LoginView(username: $username)
            } else {
                if let currentUser = realmApp.currentUser {
                    DrawingPickerView(username: username)
                        .environment(\.realmConfiguration,
                                      currentUser.flexibleSyncConfiguration())
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
