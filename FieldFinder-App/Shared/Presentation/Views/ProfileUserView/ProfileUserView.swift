//
//  ProfileUserView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//

import SwiftUI

struct ProfileUserView: View {
    @Environment(AppState.self) var appState
    
    @State var viewModel = ProfileUserViewModel()
    @State private var favoritesViewModel = GetNearbyEstablishmentsViewModel()
    @State private var showDeleteUserAlert = false
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    
    var body: some View {
       
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.primaryColorGreen)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.getMeData.name)
                                .font(.title3)
                            Text(viewModel.getMeData.email)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                Section {
                    NavigationLink("Editar perfil") {
                        EditProfileView(currentName: viewModel.getMeData.name)
                    }
                    NavigationLink("Condiciones de uso") {
                        TermsAndConditionsView()
                    }
                    
                    HStack {
                        Text("Versión de al app")
                        Spacer()
                        Text(appVersion)
                            .foregroundStyle(.gray)
                    }
                }
                
                Section {
                    NavigationLink {
                        FavoritesView(viewModel: favoritesViewModel)
                    } label: {
                        Text("Mis favoritos")
                            .foregroundStyle(.primaryColorGreen)
                    }
                }
                
                
                Section {
                    Button(role: .destructive) {
                        appState.closeSessionUser()
                    } label: {
                        Text("Cerrar sesión")
                    }
                }
                
                Section {
                    Button {
                        showDeleteUserAlert = true
                    } label: {
                        Text("Borrar cuenta")
                    }
                }
                .navigationTitle("Perfil")
            }
            .onAppear {
                Task {
                    try await viewModel.getMe()
                }
            }
            .alert("Borrar mi cuenta", isPresented: $showDeleteUserAlert) {
                Button("Eliminar", role: .destructive) {
                    Task {
                        try await viewModel.delete()
                    }
                    appState.status = .login
                }
                
                Button("Cancelar", role: .cancel) { }
            } message: {
                Text("Estas seguro que quieres eliminar tu cuenta?")
            }
        }
    }
}

#Preview {
    ProfileUserView()
        .environment(AppState())
}
