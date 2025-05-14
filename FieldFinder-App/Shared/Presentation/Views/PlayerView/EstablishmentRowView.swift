//
//  EstablishmentRowView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import SwiftUI

struct EstablishmentRowView: View {
    let establishment: Establecimiento
    @State private var isFavorite = false
    @State private var animateFavorite = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                RemoteImageCardView(url: establishment.photoEstablishment.first, height: 250)
                
                // Botón de favorito
                FavoriteButton(isFavorite: $isFavorite)
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
    EstablishmentRowView(establishment: .sample)
}



