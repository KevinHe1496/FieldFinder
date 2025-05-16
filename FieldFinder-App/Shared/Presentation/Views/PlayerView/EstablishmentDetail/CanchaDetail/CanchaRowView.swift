//
//  CanchaRowView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import SwiftUI

import SwiftUI

struct CanchaRowView: View {
    let cancha: Cancha

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topLeading) {
                RemoteImageCardView(url: cancha.photoCanchas.first, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // Etiqueta en la esquina
                Text(cancha.tipo.capitalized)
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.white)
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
                        .foregroundColor(.gray)
                    Text("$\(String(format: "%.2f", cancha.precio)) por hora")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 4)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 4)
        )
    }
}


#Preview {
    CanchaRowView(cancha: .sample)
}
