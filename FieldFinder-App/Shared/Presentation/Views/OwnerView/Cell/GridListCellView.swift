//
//  GridListCellView.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 14/5/25.
//

import SwiftUI

struct GridListCellView: View {
    
    let canchaResponse: CanchaResponse
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
                RemoteImageCardView(url: canchaResponse.photoCancha.first, height: 250)
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text(canchaResponse.modalidad)
                    .font(.appSubtitle)
                    .foregroundStyle(.primaryColorGreen)
                
                
                HStack {
                    Image(systemName: "pin.fill")
                        .foregroundStyle(.primaryColorGreen)
                    Text("$\(canchaResponse.precio) por hora")
                        .font(.appDescription)
                        .foregroundStyle(.secondaryColorBlack)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}

#Preview {
    GridListCellView(canchaResponse: .sample)
}
