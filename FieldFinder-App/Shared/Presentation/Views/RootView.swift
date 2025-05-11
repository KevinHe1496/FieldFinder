//
//  RootView.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 8/5/25.
//

import SwiftUI

struct RootView: View {
    
    @Environment(AppState.self) var appState
    
    var body: some View {
        switch appState.status {
        case .none:
            LoginView()
        case .loading:
            LoadingView()
        case .loaded:
            if let role = appState.userRole {
                switch role {
                    
                case .dueno:
                   OwnerView()
                case .jugador:
                   AppTabBarView()
                }
            } else {
                Text("Loading... no sirve nose por que")
            }
            
        case .register:
            RegisterOwnerView()
        case .error(error: let errorString):
            Text("Error \(errorString)")
        }
    }
}

#Preview {
    RootView()
        .environment(AppState())
}
