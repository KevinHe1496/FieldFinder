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

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                if let firstPhotoURL = establishment.photoEstablishment.first {
                    AsyncImage(url: firstPhotoURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 12))

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                                .foregroundColor(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                        .foregroundColor(.gray)
                }

                // Botón de favorito
                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .foregroundColor(.red)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding(15)
                }
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
