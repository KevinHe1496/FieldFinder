//
//  FavoritesView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: GetNearbyEstablishmentsViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.favoritesData) { establishment in
                        FavoriteEstablishmentRowView(establishment: establishment, viewModel: viewModel)
                            .transition(.slide)
                    }
                }
                .animation(.easeInOut, value: viewModel.favoritesData)
                .navigationTitle("Favoritos")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    Task {
                        try? await viewModel.getFavoritesUser()
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesView(viewModel: GetNearbyEstablishmentsViewModel())
}
