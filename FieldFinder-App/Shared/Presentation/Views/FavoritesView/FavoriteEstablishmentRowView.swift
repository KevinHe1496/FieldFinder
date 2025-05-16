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
        _isFavorite = State(initialValue: true) // ya está en favoritos
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
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
                            .fill(Color.gray.opacity(0.15))
                            .frame(height: 180)
                        ProgressView()
                    }
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(establishment.name)
                    .font(.headline)
                    .foregroundColor(.primaryColorGreen)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.gray)
                    Text(establishment.address)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }

            }
            .padding(.horizontal, 4)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 3)
        )
        .padding(.horizontal)
    }
}
