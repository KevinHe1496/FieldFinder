//
//  ProfileEstablishmentView.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 16/5/25.
//

import SwiftUI

struct ProfileEstablishmentView: View {
    
    
    @Environment(AppState.self) var appState
    
    @State var viewModel = ProfileUserViewModel()
    @State private var favoritesViewModel = GetNearbyEstablishmentsViewModel()
    @State private var showDeleteUserAlert = false
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    
    var body: some View {
        
        NavigationStack {
            Group {
                switch viewModel.status {
                case .idle, .loading:
                    ProgressView("Cargando...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.3)
                    
                case .success(let user):
                    List {
                        Section {
                            HStack(spacing: 16) {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.primaryColorGreen)
                                
                                VStack(alignment: .leading) {
                                    Text(user.establecimiento[0].name)
                                        .font(.title3)
                                    Text(user.email)
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        
                        Section {
                            NavigationLink("Mi Establecimiento") {
                                EditProfileEstablishmentView(
                                    name: user.establecimiento[0].name,
                                    info: user.establecimiento[0].info,
                                    country: user.establecimiento[0].country,
                                    address: user.establecimiento[0].address,
                                    city: user.establecimiento[0].city,
                                    zipcode: user.establecimiento[0].zipCode,
                                    phone: user.establecimiento[0].phone,
                                    establishmentID: user.establecimiento[0].id,
                                    parqueadero: user.establecimiento[0].parquedero,
                                    vestidores: user.establecimiento[0].vestidores,
                                    bar: user.establecimiento[0].bar,
                                    banos: user.establecimiento[0].banos,
                                    duchas: user.establecimiento[0].duchas, appState: appState
                                    
                                )
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
                            NavigationLink("Mis Canchas") {
                                OwnerView()
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
                    }
                    .padding(.top, 4)
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemGroupedBackground))
                    .navigationTitle("Perfil")
                    
                case .error(let message):
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.primaryColorGreen)
                        Text("Error al cargar el perfil.")
                            .font(.headline)
                        Text(message)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding()
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
            .onAppear {
                Task {
                    try await viewModel.getMe()
                }
            }
        }
    }
}



#Preview {
    ProfileEstablishmentView()
        .environment(AppState())
}
