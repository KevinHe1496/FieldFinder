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
    var viewModel: GetNearbyEstablishmentsViewModel

    init(establishment: FavoriteEstablishment, viewModel: GetNearbyEstablishmentsViewModel) {
        self.establishment = establishment
        self.viewModel = viewModel
        _isFavorite = State(initialValue: true) // como viene de favoritos, es true
    }

    var body: some View {
        ScrollView {
            HStack {
                AsyncImage(url: viewModel.favoritesData.first?.photoEstablishment.first) { image in
                    image
                        .resizable()
                        .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                Text(establishment.name)
                Spacer()
            }
            .padding()
        }
    }
}
