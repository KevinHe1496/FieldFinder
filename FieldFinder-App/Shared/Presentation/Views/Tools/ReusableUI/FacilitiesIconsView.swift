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
        let items = facilityItems()

        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                facilityBox(name: items[index].icon, label: items[index].label)

                // Separador entre cajas, excepto después del último
                if index < items.count - 1 {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 1, height: 60)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }

    private func facilityItems() -> [(icon: String, label: String)] {
        var result: [(String, String)] = []

        if parquedero { result.append(("car.fill", "Parqueo")) }
        if vestidores { result.append(("tshirt.fill", "Vestidores")) }
        if banos      { result.append(("toilet.fill", "Baños")) }
        if duchas     { result.append(("drop.fill", "Duchas")) }
        if bar        { result.append(("cup.and.saucer.fill", "Bar")) }

        return result
    }

    private func facilityBox(name: String, label: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: name)
                .font(.title2)
                .foregroundColor(.primaryColorGreen)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondaryColorBlack)
        }
        .frame(width: 70, height: 60)
        .background(Color.white) // O cualquier fondo que prefieras
    }
}
