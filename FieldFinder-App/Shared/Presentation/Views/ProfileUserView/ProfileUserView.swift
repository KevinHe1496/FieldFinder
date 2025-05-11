//
//  ProfileUserView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//

import SwiftUI

struct ProfileUserView: View {
    @Environment(AppState.self) var appState
    
    var body: some View {
        
        Button("Cerrar sesion") {
            appState.closeSessionUser()
        }
    }
}

#Preview {
    ProfileUserView()
}
