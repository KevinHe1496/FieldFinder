//
//  OwnerView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//

import SwiftUI

struct OwnerView: View {
    
    @Environment(AppState.self) var appState
    
    @State private var viewModel = OwnerViewModel()
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                if viewModel.establishments.establecimiento.first?.canchas.isEmpty ?? true {
                    VStack {
                        
                        ContentUnavailableView("No hay canchas registradas", systemImage: "soccerball.inverse", description: Text("Agrega algunas canchas."))
                       
                    }
                    .padding(.top, 250)
                    
                } else {
                   
                   
                    
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.establishments.establecimiento) { establecimiento in
                            ForEach(establecimiento.canchas) { cancha in
                                NavigationLink {
                                    CanchaDetailView(fieldId: cancha.id)
                                } label: {
                                   GridListCellView(canchaResponse: cancha)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Canchas")
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    NavigationLink {
                        RegisterField()
                        
                    } label: {
                      Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                    }
                    .tint(.primaryColorGreen)
                }
                
            }
            .onAppear {
                Task {
                     await viewModel.getEstablishments()
                }
            }
        }
    }
}

#Preview {
    OwnerView()
        .environment(AppState())
}
