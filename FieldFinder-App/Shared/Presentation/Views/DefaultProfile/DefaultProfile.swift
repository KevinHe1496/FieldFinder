//
//  DefaultProfile.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 19/5/25.
//

import SwiftUI

struct DefaultProfile: View {
    @Environment(AppState.self) var appState
    @State var viewModel = ProfileUserViewModel()
    
    @State var showRegisterSheet: Bool = false
    @State var showLoginSheet: Bool = false
    
    
    
    var body: some View {
        
        if viewModel.getMeData.rol == "dueno" {
            ProfileEstablishmentView()
        } else if viewModel.getMeData.rol == "jugador" {
            ProfileUserView(appState: _appState)
        } else {
            NavigationStack {
                
                CustomButtonView(title: "Iniciar Sesión", color: Color.primaryColorGreen, textColor: Color.thirdColorWhite, action: {
                    showLoginSheet.toggle()
                })
                CustomButtonView(title: "Registrar", color: Color.primaryColorGreen, textColor: Color.thirdColorWhite, action: {
                    showRegisterSheet.toggle()
                })
                
                
                .sheet(isPresented: $showRegisterSheet) {
                    RegisterView(appState: appState)
                }
                .sheet(isPresented: $showLoginSheet) {
                   LoginView()
                }
                .onAppear {
                    Task {
                        try await viewModel.getMe()
                    }
                }
                
            }
        }
    }
}

#Preview {
    DefaultProfile()
        .environment(AppState())
}
