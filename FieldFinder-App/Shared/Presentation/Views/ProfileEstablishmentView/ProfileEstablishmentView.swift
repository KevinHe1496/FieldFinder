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
            List {
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.primaryColorGreen)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.getMeData.establecimiento[0].name)
                                .font(.title3)
                            Text(viewModel.getMeData.email)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                Section {
                    NavigationLink("Editar Establecimiento") {
                        EditProfileEstablishmentView(
                            name: viewModel.getMeData.establecimiento[0].name,
                            info: viewModel.getMeData.establecimiento[0].info,
                            country: viewModel.getMeData.establecimiento[0].country,
                            address: viewModel.getMeData.establecimiento[0].address,
                            city: viewModel.getMeData.establecimiento[0].city,
                            zipcode: viewModel.getMeData.establecimiento[0].zipCode,
                            phone: viewModel.getMeData.establecimiento[0].phone,
                            establishmentID: viewModel.getMeData.establecimiento[0].id,
                            parqueadero: viewModel.getMeData.establecimiento[0].parquedero,
                            vestidores: viewModel.getMeData.establecimiento[0].vestidores,
                            bar: viewModel.getMeData.establecimiento[0].bar,
                            banos: viewModel.getMeData.establecimiento[0].banos,
                            duchas: viewModel.getMeData.establecimiento[0].duchas, appState: appState
                          
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
            
            .alert("Borrar mi cuenta", isPresented: $showDeleteUserAlert) {
                Button("Eliminar", role: .destructive) {
                    Task {
                        try await viewModel.delete()
                    }
                    appState.status = .none
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
