//
//  RootView.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 8/5/25.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasSeenWelcome") var hasSeenWelcome = false
    @Environment(AppState.self) var appState
    
    var body: some View {
        switch appState.status {
        case .none:
            if hasSeenWelcome {
                AppTabBarView()
            } else {
                WelcomeView(hasSeenWelcome: $hasSeenWelcome)
            }
        case .loading:
            LoadingView()
        case .home:
            AppTabBarView()
        case .registerUser:
            RegisterView(appState: appState)
        
        case .loaded:
            if let role = appState.userRole {
                switch role {
                    
                case .dueno:
                    AppTabBarOwnerView()
                case .jugador:
                    AppTabBarView()
                }
            } else {
                Text("Loading... no sirve nose por que")
            }
            
        case .register:
            RegisterOwnerView(appState: appState)
        case .error(error: let errorString):
            Text("Error \(errorString)")
        case .ownerView:
            OwnerView()
        case .registerCancha:
            RegisterField()
        }
    }
}

#Preview {
    RootView()
        .environment(AppState())
}
