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
                        Spacer()
                        ContentUnavailableView("No hay canchas registradas", systemImage: "soccerball.inverse", description: Text("Agrega algunas canchas."))
                        Spacer()
                    }
                    .frame(minHeight: UIScreen.main.bounds.height)
                    
                } else {
                   
                   
                    
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.establishments.establecimiento[0].canchas) { cancha in
                            NavigationLink {
                                CanchaDetailView(fieldId: cancha.id)
                            } label: {
                                GridListCellView(canchaResponse: cancha)
                            }
                        }
                    }
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Canchas")
                        .font(.appTitle)
                        .foregroundStyle(.primaryColorGreen)
                }
                
                ToolbarItem(placement: .topBarTrailing) {

                    NavigationLink {
                        RegisterOwnerView(appState: appState)
                    } label: {
                      Label("Add", systemImage: "plus.circle.fill")
                            .font(.title)
                            .foregroundStyle(.primaryColorGreen)
                            .background(Color.primaryColorGreen)
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
