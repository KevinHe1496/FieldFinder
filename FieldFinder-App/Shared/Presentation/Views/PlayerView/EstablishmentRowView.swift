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
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                RemoteImageCardView(url: establishment.photoEstablishment.first, height: 200)
                
                // Botón de favorito
                FavoriteButton(isFavorite: $isFavorite) { newValue in
                    Task {
                            try await viewModel.toggleFavorite(
                                establishmentId: establishment.id,
                                isFavorite: newValue
                            )
                        }
                }
                    .padding(15)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(establishment.name)
                    .font(.appSubtitle)
                    .foregroundStyle(.primaryColorGreen)
                
                
                HStack {
                    Image(systemName: "pin.fill")
                        .foregroundStyle(.primaryColorGreen)
                    Text(establishment.address)
                        .font(.appDescription)
                        .foregroundStyle(.secondaryColorBlack)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}


#Preview {
    EstablishmentRowView(establishment: .sample, viewModel: GetNearbyEstablishmentsViewModel())
}



