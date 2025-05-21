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
                .foregroundStyle(.primary)
                .font(.caption)
                .fixedSize()
                .padding(4)
                .background(.thirdColorWhite)
                .cornerRadius(5)
        }
    }
}

#Preview {
    EstablishmentAnnotationView(establishment: .sample)
}
