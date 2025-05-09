//
//  LoginView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 8/5/25.
//


import SwiftUI

// 1. Enum con los roles
enum UserRole: String, CaseIterable, Identifiable {
    case jugador = "Jugador"
    case dueno = "Dueño"
    
    var id: String { self.rawValue }
}


struct RegisterView: View {
    
    // MARK: - State Properties
    @State private var email = ""
    @State private var password = ""
    @State private var selectedRole: UserRole = .jugador
    
    var body: some View {
        NavigationStack {
            
            VStack {
                VStack {
                    // MARK: - Logo Image
                    Image(.splashLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                    
                    
                    // MARK: - Login Form Section
                    Section {
                        VStack(spacing: 15) {
                            // Email input field
                            CustomTextFieldLogin(
                                titleKey: "Email",
                                textField: $email,
                                keyboardType: .emailAddress,
                                prompt: Text(
                                    "Enter your email"
                                ), Bgcolor: .thirdColorWhite
                                
                            )
                            
                            // Password input field
                            CustomSecureFieldView(titleKey: "Password", textField: $password, keyboardType: .default, prompt: Text("Enter your password"))
                            
                            
                            // Rol
                            HStack {
                                Text("Selecciona tu rol:")
                                    .font(.appDescription)
                                Spacer()
                                Picker("Selecciona tu rol", selection: $selectedRole) {
                                    ForEach(UserRole.allCases) { role in
                                        Text(role.rawValue)
                                            .tag(role)
                                    }
                                }
                                .pickerStyle(.menu)
                                .frame(width: 120)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 55)
                            .background(Color.white)
                            .clipShape(.buttonBorder)
                            
                            // Sign in button
                            CustomButtonLoginRegister(title: "Registrar", color: .thirdColorWhite, textColor: .secondaryColorBlack) {
                                // To do
                            }
                        }
                    } header: {
                        HStack {
                            Text("CREA TU CUENTA")
                                .font(.appTitle)
                                .foregroundStyle(.primaryColorGreen)
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.secondaryColorBlack)
        }
    }
}

#Preview {
    RegisterView()
}
