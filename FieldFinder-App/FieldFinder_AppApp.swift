//
//  FieldFinder_AppApp.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 8/5/25.
//

import SwiftUI

@main
struct FieldFinder_AppApp: App {
    
    @State var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
        }
    }
}
