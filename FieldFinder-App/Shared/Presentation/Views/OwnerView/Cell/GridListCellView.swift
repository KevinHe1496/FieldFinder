//
//  GridListCellView.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 14/5/25.
//

import SwiftUI

struct GridListCellView: View {
    
    let canchaResponse: FieldResponse
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                RemoteImageCardView(url: canchaResponse.photoCanchas.first, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4)

            }

            VStack(alignment: .leading, spacing: 6) {
                Text(canchaResponse.modalidad)
                    .font(.headline)
                    .foregroundStyle(.primaryColorGreen)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(.gray)
                    Text("$\(String(format: "%.2f", canchaResponse.precio)) por hora")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            .padding(.horizontal, 4)
        }
        .padding()
        .background(.thirdColorWhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
        .padding(.horizontal)

    }
}

#Preview {
    GridListCellView(canchaResponse: .sample)
}
