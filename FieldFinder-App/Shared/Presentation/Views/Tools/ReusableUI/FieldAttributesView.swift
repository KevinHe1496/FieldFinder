//
//  FieldAttributesView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//


import SwiftUI

struct FieldAttributesView: View {
    let iluminada: Bool
    let cubierta: Bool

    var body: some View {
        let items = [
            ("lightbulb.fill", "Iluminada", iluminada),
            ("house.fill", "Cubierta", cubierta)
        ]

        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                attributeBox(name: items[index].0,
                             label: items[index].1,
                             isAvailable: items[index].2)

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

    private func attributeBox(name: String, label: String, isAvailable: Bool) -> some View {
        VStack(spacing: 4) {
            if isAvailable {
                Image(systemName: name)
                    .font(.title2)
                    .foregroundColor(.primaryColorGreen)
            } else {
                Image(systemName: "xmark.circle")
                    .font(.title2)
                    .foregroundColor(.red)
            }

            Text(label)
                .font(.caption)
                .foregroundStyle(.primary)
        }
        .frame(width: 70, height: 60)
        .background(.thirdColorWhite)
    }
}
