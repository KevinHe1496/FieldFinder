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
        let items = [
            ("car.fill", "Parqueo", parquedero),
            ("tshirt.fill", "Vestidores", vestidores),
            ("toilet.fill", "Baños", banos),
            ("drop.fill", "Duchas", duchas),
            ("cup.and.saucer.fill", "Bar", bar)
        ]

        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                facilityBox(name: items[index].0,
                            label: items[index].1,
                            isAvailable: items[index].2)

                if index < items.count - 1 {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 1, height: 60)
                }
            }
        }
        .background(.thirdColorWhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }

    private func facilityBox(name: String, label: String, isAvailable: Bool) -> some View {
        VStack(spacing: 4) {
            if isAvailable {
                Image(systemName: name)
                    .font(.title2)
                    .foregroundStyle(.primaryColorGreen)
            } else {
                Image(systemName: "xmark.circle")
                    .font(.title2)
                    .foregroundStyle(.red)
            }

            Text(label)
                .font(.caption)
                .foregroundStyle(.primary)
        }
        .frame(width: 70, height: 60)
        .background(.thirdColorWhite)
    }
}
