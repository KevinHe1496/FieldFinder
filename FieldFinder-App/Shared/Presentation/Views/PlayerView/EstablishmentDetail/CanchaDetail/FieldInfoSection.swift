//
//  FieldInfoSection.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 16/5/25.
//


import SwiftUI

struct FieldInfoSection: View {
    let fieldData: Cancha

    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Información")
                    .font(.title3.bold())
                    .foregroundColor(.primaryColorGreen)

                Divider()

                Text("Cancha de: \(fieldData.tipo)")
                Text("Juego de: \(fieldData.modalidad)")
                Text("Precio: $\(fieldData.precio, specifier: "%.2f") por hora")
            }
        }
    }
}
