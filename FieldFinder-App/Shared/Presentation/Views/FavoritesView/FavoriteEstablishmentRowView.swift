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
        VStack(alignment: .leading, spacing: 12) {
            // Imagen del establecimiento
            AsyncImage(url: establishment.photoEstablishment.first) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(16)
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 180)
                    ProgressView()
                }
            }

            // Nombre y favorito
            HStack {
                Text(establishment.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.3), radius: 6, x: 0, y: 4)
        .padding(.horizontal)
    }
}
