//
//  CanchaRowView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import SwiftUI

import SwiftUI

struct CanchaRowView: View {
    let cancha: FieldResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topLeading) {
                RemoteImageCardView(url: cancha.photoCanchas.first)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // Etiqueta en la esquina
                Text(cancha.tipo.capitalized)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.primaryColorGreen.opacity(0.85))
                    .clipShape(Capsule())
                    .padding(8)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(cancha.modalidad)
                    .font(.headline)
                    .foregroundStyle(.primaryColorGreen)

                HStack(spacing: 4) {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(.primaryColorGreen)
                    Text("$\(String(format: "%.2f", cancha.precio)) por hora")
                        .font(.subheadline)
                        .foregroundStyle(.colorBlack)
                }
            }
            .padding(.horizontal, 4)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}


#Preview {
    CanchaRowView(cancha: .sample)
}
