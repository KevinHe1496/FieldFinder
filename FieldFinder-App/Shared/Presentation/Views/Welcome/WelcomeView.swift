//
//  WelcomeView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 19/5/25.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(AppState.self) var appState
    @Binding var hasSeenWelcome: Bool
    var body: some View {
        NavigationStack {
            VStack {
                Image(.splashLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                
                VStack(spacing: 20) {
                    Text("BIENVENIDO A FIELD FINDER")
                        .font(.appTitle)
                        .foregroundStyle(.primaryColorGreen)
                    
                    Text("Encuentra canchas deportivas cerca de ti o regístrate como dueño para administrar tus espacios.")
                        .font(.appDescription)
                        .foregroundStyle(.thirdColorWhite)
                    
                    NavigationLink {
                        AppTabBarView()
                    } label: {
                        CustomButtonView(title: "Continuar", color: .primaryColorGreen, textColor: .thirdColorWhite) {
                            hasSeenWelcome = true
                            appState.status = .home
                        }
                    }
                    
                    NavigationLink {
                        AppTabBarView()
                    } label: {
                        CustomButtonView(title: "Registrar Establecimiento", color: .primaryColorGreen, textColor: .thirdColorWhite) {
                            appState.status = .registerUser
                        }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.secondaryColorBlack)
        }
    }
}

#Preview {
    WelcomeView(hasSeenWelcome: .constant(false))
        .environment(AppState())
}
