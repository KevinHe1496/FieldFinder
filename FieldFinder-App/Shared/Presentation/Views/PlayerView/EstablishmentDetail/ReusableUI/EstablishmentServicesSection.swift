//
//  EstablishmentServicesSection.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 16/5/25.
//


import SwiftUI

struct EstablishmentServicesSection: View {
    let establishment: Establecimiento

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Servicios disponibles")
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .foregroundColor(.primaryColorGreen)
                
                FacilitiesIconsView(
                    parquedero: establishment.parquedero,
                    vestidores: establishment.vestidores,
                    banos: establishment.banos,
                    duchas: establishment.duchas,
                    bar: establishment.bar
                )
            }
        }
        .padding(20)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
