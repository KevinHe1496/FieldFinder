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
        CardView {
            VStack(alignment: .leading, spacing: 12) {
                Text(establishment.name)
                    .font(.title2.bold())
                    .foregroundColor(.primaryColorGreen)

                Divider()

                Label(establishment.address, systemImage: "mappin.and.ellipse")
                Label(establishment.phone, systemImage: "phone.fill")

                Divider()

                Text(establishment.info)
                    .font(.body)
            }
        }
    }

    private func callEstablishment(phone: String) {
        let formatted = phone.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        if let url = URL(string: "tel://\(formatted)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
