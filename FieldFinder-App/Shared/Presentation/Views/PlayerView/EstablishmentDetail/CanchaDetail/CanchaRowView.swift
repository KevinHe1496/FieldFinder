//
//  CanchaRowView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import SwiftUI

struct CanchaRowView: View {
    let cancha: Cancha
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                RemoteImageCardView(url: cancha.photoCanchas.first, height: 200)
                
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(cancha.modalidad)
                    .font(.appSubtitle)
                    .foregroundStyle(.primaryColorGreen)
                
                
                HStack {
                 
                    Text("$\(cancha.precio) por hora.")
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
    CanchaRowView(cancha: .sample)
}
