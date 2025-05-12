//
//  EstablishmentRowView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import SwiftUI

struct EstablishmentRowView: View {
    let establishment: Establecimiento
    
    var body: some View {
        VStack(alignment: .leading) {
            if let firstPhotoURL = establishment.photoEstablishment.first {
                AsyncImage(url: firstPhotoURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, minHeight: 150)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(establishment.name)
                    .font(.appSubtitle)
                    .padding(.top, 4)
                
                HStack {
                    Image(systemName: "pin.fill")
                        .foregroundStyle(.primaryColorGreen)
                    Text(establishment.address)
                        .font(.appDescription)
                }
            }
        }
        .padding()
    }
}

#Preview {
    EstablishmentRowView(establishment: .sample)
}
