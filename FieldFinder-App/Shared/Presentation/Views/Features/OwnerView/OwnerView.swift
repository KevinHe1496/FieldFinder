//
//  OwnerView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//

import SwiftUI

struct OwnerView: View {
    
    @Environment(AppState.self) var appState
    @State private var shownItems: Set<String> = []
    
    @State private var viewModel = OwnerViewModel()
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                ScrollView {
                    if viewModel.establishments.establecimiento.first?.canchas.isEmpty ?? true {
                        VStack {
                            
                            ContentUnavailableView("No hay canchas registradas", systemImage: "soccerball.inverse", description: Text("Agrega algunas canchas."))
                            
                        }
                        .padding(.top, 250)
                        
                    } else {

                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.establishments.establecimiento) { establecimiento in
                                ForEach(establecimiento.canchas) { cancha in
                                    NavigationLink {
                                        FieldDetailView(fieldId: cancha.id, userRole: viewModel.establishments.userRole)
                                    } label: {
                                        AnimatedAppearRow(item: cancha, shownItems: $shownItems) {
                                           FieldGridItemView(field: cancha)
                                        }
                                        
                                    }
                                }
                            }
                        }
                        .padding(.top)
                        .padding(.bottom)
                    }
                    
                }
                .navigationTitle("Mis Canchas")
                .toolbar {
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        NavigationLink {
                            RegisterFieldView()
                            
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                        }
                        .tint(.primaryColorGreen)
                    }
                    
                }
                .task {
                    await viewModel.getEstablishments()
                    
                    // 🔁 Marca todos los ítems como mostrados si no hay scroll
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        for establecimiento in viewModel.establishments.establecimiento {
                            for cancha in establecimiento.canchas {
                                _ = shownItems.insert(cancha.id)
                            }
                        }
                    }
                }
                
            }
        }
    }
}

#Preview {
    OwnerView()
        .environment(AppState())
}
