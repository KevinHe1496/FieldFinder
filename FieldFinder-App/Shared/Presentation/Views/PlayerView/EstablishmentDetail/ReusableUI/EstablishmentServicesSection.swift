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
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Servicios disponibles")
                    .font(.headline)
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
    }
}
