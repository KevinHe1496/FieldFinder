//
//  FacilitiesIconsView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import SwiftUI

struct FacilitiesIconsView: View {
    let parquedero: Bool
    let vestidores: Bool
    let banos: Bool
    let duchas: Bool
    let bar: Bool

    var body: some View {
        HStack(spacing: 16) {
            if parquedero {
                facilityIcon(name: "car.fill", label: "Parqueadero")
            }
            if vestidores {
                facilityIcon(name: "tshirt.fill", label: "Vestidores")
            }
            if banos {
                facilityIcon(name: "toilet.fill", label: "Baños")
            }
            if duchas {
                facilityIcon(name: "drop.fill", label: "Duchas")
            }
            if bar {
                facilityIcon(name: "cup.and.saucer.fill", label: "Bar")
            }
        }
        .padding(.horizontal)
    }

    private func facilityIcon(name: String, label: String) -> some View {
        VStack {
            Image(systemName: name)
                .font(.title2)
                .foregroundColor(.primaryColorGreen)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondaryColorBlack)
        }
    }
}
