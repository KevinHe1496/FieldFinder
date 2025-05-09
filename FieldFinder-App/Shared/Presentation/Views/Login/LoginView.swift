//
//  LoginView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 8/5/25.
//


import SwiftUI

struct LoginView: View {
    
    #if DEBUG
    // MARK: - State Properties
    @State private var email = "andy@example.com"
    @State private var password = "123456"
    #else
    @State private var email = ""
    @State private var password = ""
    #endif
    
    @Environment(AppState.self) var appState
    
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
                                )
                                , Bgcolor: .thirdColorWhite
                                
                            )
                            
                            // Password input field
                            CustomSecureFieldView(titleKey: "Password", textField: $password, keyboardType: .default, prompt: Text("Enter your password"))
                            
                            // Sign in button
                            
                            CustomButtonLoginRegister(title: "Sign In", color: .thirdColorWhite, textColor: .secondaryColorBlack) {
                                // To do
                                appState.loginApp(user: email, password: password)
                            }
                            
                            Button {
                                // To do
                            } label: {
                                Text("Forgot your password?")
                                    .font(.appDescription)
                                    .foregroundStyle(.thirdColorWhite)
                            }
                            
                            // MARK: - Social Media Sign up
                            
                            Text("- OR SIGN IN WITH -")
                                .font(.appTitle)
                                .foregroundStyle(.primaryColorGreen)
                            
                            HStack(spacing: 15) {
                                Button {
                                    //TO DO
                                } label: {
                                    Text("G")
                                        .font(.appButton)
                                        .frame(width: 70, height: 70)
                                        .foregroundStyle(.secondaryColorBlack)
                                        .background(Color.thirdColorWhite)
                                        .clipShape(.buttonBorder)
                                }
                                
                                Button {
                                    //TO DO
                                } label: {
                                    Text("F")
                                        .font(.appButton)
                                        .frame(width: 70, height: 70)
                                        .foregroundStyle(.secondaryColorBlack)
                                        .background(Color.thirdColorWhite)
                                        .clipShape(.buttonBorder)
                                }
                                
                                Button {
                                    //TO DO
                                } label: {
                                    Text("T")
                                        .font(.appButton)
                                        .frame(width: 70, height: 70)
                                        .foregroundStyle(.secondaryColorBlack)
                                        .background(Color.thirdColorWhite)
                                        .clipShape(.buttonBorder)
                                }
                            }
                        }
                        
                    } header: {
                        HStack {
                            Text("LOGIN TO YOUR ACCOUNT")
                                .font(.appTitle)
                                .foregroundStyle(.primaryColorGreen)
                            Spacer()
                        }
                        
                    }
                    Spacer()
                    Button {
                        // To do
                    } label: {
                        Text("Don't have an account? **Sign Up**")
                            .font(.appDescription)
                            .foregroundStyle(.thirdColorWhite)
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
    LoginView()
        .environment(AppState())
}
