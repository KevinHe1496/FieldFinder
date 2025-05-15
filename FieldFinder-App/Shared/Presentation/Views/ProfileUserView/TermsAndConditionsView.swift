//
//  TermsAndConditionsView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 14/5/25.
//


import SwiftUI

struct TermsAndConditionsView: View {
    var body: some View {
        ScrollView {
            Text("""
            Términos y condiciones:

            Al usar esta app, aceptas los siguientes términos...

            1. No usar con fines ilegales.
            2. No compartir tu cuenta.
            3. Nosotros no garantizamos disponibilidad 24/7.

            Gracias por confiar en FieldFinder.
            """)
            .padding()
        }
        .navigationTitle("Condiciones de uso")
    }
}
