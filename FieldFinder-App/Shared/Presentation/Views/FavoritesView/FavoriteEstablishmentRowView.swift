//
//  FavoriteEstablishmentRowView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//
import SwiftUI

struct FavoriteEstablishmentRowView: View {
    let establishment: FavoriteEstablishment
    @State private var isFavorite: Bool
    var viewModel: PlayerViewModel

    init(establishment: FavoriteEstablishment, viewModel: PlayerViewModel) {
        self.establishment = establishment
        self.viewModel = viewModel
        _isFavorite = State(initialValue: true) // como viene de favoritos, es true
    }

    var body: some View {
        HStack {
            Text(establishment.name)
            Spacer()
            FavoriteButton(isFavorite: $isFavorite) { newValue in
                Task {
                    try? await viewModel.toggleFavorite(establishmentId: establishment.id, isFavorite: newValue)
                }
            }
        }
        .padding()
    }
}
