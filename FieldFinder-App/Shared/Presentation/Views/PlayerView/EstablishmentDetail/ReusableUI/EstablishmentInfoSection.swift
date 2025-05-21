//
//  EstablishmentInfoSection.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 16/5/25.
//


import SwiftUI

struct EstablishmentInfoSection: View {
    let establishment: Establecimiento

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                Text(establishment.name)
                    .font(.title2.bold())
                    .foregroundStyle(.primaryColorGreen)

                Divider()
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundStyle(.primaryColorGreen)
                    Text(establishment.address)
                }
                
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundStyle(.primaryColorGreen)
                    Text(establishment.phone)
                }

                Divider()

                Text(establishment.info)
                    .font(.body)
            }
            .padding(.horizontal, 20)
        }
        .padding(20)
        .background(.thirdColorWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }

    private func callEstablishment(phone: String) {
        let formatted = phone.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        if let url = URL(string: "tel://\(formatted)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
