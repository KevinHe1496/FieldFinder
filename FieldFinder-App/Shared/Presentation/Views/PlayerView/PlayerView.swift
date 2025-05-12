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
    @State private var viewModel = PlayerViewModel()
    
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
                            EstablishmentRowView(establishment: establishment)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Canchas")
            .onAppear {
                Task {
                    try await viewModel.loadData()
                }
            }
        }
    }
}

#Preview {
    PlayerView()
}
