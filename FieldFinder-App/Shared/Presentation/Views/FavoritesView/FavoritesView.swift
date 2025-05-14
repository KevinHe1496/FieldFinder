//
//  FavoritesView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.favoritesData) { establishment in
                    FavoriteEstablishmentRowView(establishment: establishment, viewModel: viewModel)
                        .transition(.slide)
                }
            }
            .animation(.easeInOut, value: viewModel.favoritesData)
            .onAppear {
                Task {
                    try? await viewModel.getFavoritesUser()
                }
            }
        }
    }
}

#Preview {
    FavoritesView(viewModel: PlayerViewModel())
}
