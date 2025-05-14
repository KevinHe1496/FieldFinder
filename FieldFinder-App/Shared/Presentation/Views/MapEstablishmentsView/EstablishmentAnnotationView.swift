//
//  EstablishmentAnnotationView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 14/5/25.
//

import SwiftUI

struct EstablishmentAnnotationView: View {
    var establishment: Establecimiento
    
    var body: some View {
        VStack {
            Image(.logoFieldfinderTransparent)
            Text(establishment.name)
                .foregroundStyle(.thirdColorWhite)
                .font(.caption)
                .fixedSize()
                .padding(4)
                .background(Color.secondaryColorBlack.opacity(0.8))
                .cornerRadius(5)
        }
    }
}

#Preview {
    EstablishmentAnnotationView(establishment: .sample)
}
