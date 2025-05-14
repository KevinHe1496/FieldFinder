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
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(.red)
                .font(.title)
            Text(establishment.name)
                .font(.caption)
                .fixedSize()
                .padding(4)
                .background(Color.white.opacity(0.8))
                .cornerRadius(5)
        }
    }
}

#Preview {
    EstablishmentAnnotationView(establishment: .sample)
}
