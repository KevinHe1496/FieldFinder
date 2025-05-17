//
//  LoginView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 8/5/25.
//


import SwiftUI

struct RegisterView: View {
    
    // MARK: - State Properties
    
    @Environment(AppState.self) var appState
    @State private var viewModel: RegisterViewModel
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var selectedRole: UserRole = .jugador
    
    init(appState: AppState) {
        _viewModel = State(initialValue: RegisterViewModel(appState: appState))
    }
    
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
                            
                            // Name input field
                            
                            CustomTextFieldLogin(
                                titleKey: "Name",
                                textField: $name,
                                keyboardType: .default,
                                prompt: Text("Enter your name"),
                                Bgcolor: .thirdColorWhite
                            )
                            
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
                                        Text(role.displayName)
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
                            CustomButtonView(title: "Registrar", color: .thirdColorWhite, textColor: .secondaryColorBlack) {
                                Task {
                                    let error = await viewModel.userRegister(
                                        name: name,
                                        email: email,
                                        password: password,
                                        rol: selectedRole.rawValue.lowercased()
                                    )
                                    
                                    if let error = error {
                                        print("Error al registrar: \(error)")
                                    } else {
                                        print("Registro existoso")
                                    }
                                }
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
            .alert("Mensaje", isPresented: $viewModel.showAlert) {
                Button("OK") { }
            } message: {
                Text(viewModel.message ?? "")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.secondaryColorBlack)
        }
    }
}

#Preview {
    RegisterView(appState: AppState())
        .environment(AppState())
}
