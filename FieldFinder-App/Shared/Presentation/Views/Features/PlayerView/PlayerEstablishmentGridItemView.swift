//
//  EstablishmentRowView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import SwiftUI

struct PlayerEstablishmentGridItemView: View {
    
    let establishment: EstablishmentResponse
    @Binding var isFavorite: Bool
    @State var viewModelUser = ProfileUserViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                RemoteImageCardView(url: establishment.photoEstablishment.first)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4)
                    
                
                if case .success(let user) = viewModelUser.status, user.rol == "jugador" {
                    
                    FavoriteButton(isFavorite: $isFavorite)
                    .padding(12)
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(establishment.name)
                    .font(.headline)
                    .foregroundStyle(.primaryColorGreen)
                    .lineLimit(1)
                
                HStack(spacing: 6) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundStyle(.primaryColorGreen)
                    if establishment.address2 == "" {
                        Text(establishment.address)
                            .font(.subheadline)
                            .foregroundStyle(Color.colorBlack)
                            .lineLimit(2)
                    } else {
                        Text("\(establishment.address), \(establishment.address2 ?? "")")
                            .font(.subheadline)
                            .foregroundStyle(Color.colorBlack)
                            .lineLimit(1)
                    }
                }
            }
            
            .padding(.horizontal, 4)
            
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            Task {
                try await viewModelUser.getMe()
            }
        }
        .padding()
        .background(.thirdColorWhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
        .padding(.horizontal)
        
    }
}

#Preview {
    PlayerEstablishmentGridItemView(establishment: .sample, isFavorite: .constant(true))
}



