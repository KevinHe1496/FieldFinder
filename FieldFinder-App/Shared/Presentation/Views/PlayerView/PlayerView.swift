//
//  PlayerView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//

import SwiftUI
import CoreLocation

struct PlayerView: View {
    @State private var searchText = ""
    @State private var didLoad = false
    
    @ObservedObject var viewModel: GetNearbyEstablishmentsViewModel
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                HStack {
                    Text("Todos")
                        .font(.appTitle)
                    Spacer()
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.nearbyEstablishments) { establishment in
                        NavigationLink {
                            EstablishmentDetailView(establishmentId: establishment.id)
                        } label: {
                            EstablishmentRowView(establishment: establishment, viewModel: viewModel)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .searchable(text: $searchText)
            .navigationTitle("Establecimientos")
            .task {
                if !didLoad {
                    do {
                        try await viewModel.loadData()
                        didLoad = true
                    } catch {
                        print("No se pudo obtener ubicación o cargar datos: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    PlayerView(viewModel: GetNearbyEstablishmentsViewModel())
}
