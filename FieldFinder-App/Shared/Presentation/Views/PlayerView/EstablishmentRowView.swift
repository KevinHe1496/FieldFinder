//
//  EstablishmentRowView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import SwiftUI

struct EstablishmentRowView: View {
    
    let establishment: Establecimiento
    
    @State private var animateFavorite = false
    @State var viewModel: GetNearbyEstablishmentsViewModel
    @State private var isFavorite: Bool

    init(establishment: Establecimiento, viewModel: GetNearbyEstablishmentsViewModel) {
        self.establishment = establishment
        self.viewModel = viewModel
        _isFavorite = State(initialValue: establishment.isFavorite)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                RemoteImageCardView(url: establishment.photoEstablishment.first, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4)
                
                FavoriteButton(isFavorite: $isFavorite) { newValue in
                    Task {
                        try await viewModel.toggleFavorite(
                            establishmentId: establishment.id,
                            isFavorite: newValue
                        )
                    }
                }
                .padding(12)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(establishment.name)
                    .font(.headline)
                    .foregroundStyle(.primaryColorGreen)
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

#Preview {
    EstablishmentRowView(establishment: .sample, viewModel: GetNearbyEstablishmentsViewModel())
}



