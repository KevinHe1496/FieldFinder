//
//  FieldAttributesSection.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 16/5/25.
//


import SwiftUI

struct FieldAttributesSection: View {
    let fieldData: Cancha

    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Características")
                    .font(.headline)
                    .foregroundColor(.primaryColorGreen)

                FieldAttributesView(
                    iluminada: fieldData.iluminada,
                    cubierta: fieldData.cubierta
                )
            }
        }
    }
}
