//
//  EstablishmentSelectedMapDestailView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 14/5/25.
//

import SwiftUI

struct EstablishmentSelectedMapDestailView: View {
    @Environment(\.dismiss) var dismiss
    let establishment: Establecimiento
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: establishment.photoEstablishment.first) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
            } placeholder: {
                ProgressView()
            }
            
            Text(establishment.name)
                .font(.appTitle)
                .foregroundStyle(.primaryColorGreen)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(establishment.info)
                .font(.appDescription)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack {
                Image(systemName: "pin.fill")
                    .foregroundStyle(.primaryColorGreen)
                Text(establishment.address)
            }
            .font(.appDescription)
            .foregroundStyle(.secondaryColorBlack)
            
            HStack {
                Image(systemName: "phone.fill")
                    .foregroundStyle(.primaryColorGreen)
                Text(establishment.phone)
            }
            .font(.appDescription)
            .foregroundStyle(.secondaryColorBlack)
            
            CustomButtonLoginRegister(title: "Cancel", color: .primaryColorGreen, textColor: .thirdColorWhite) {
                dismiss()
            }
        }
        .padding()
    }
}

#Preview {
    EstablishmentSelectedMapDestailView(establishment: .sample)
}
