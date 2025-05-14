//
//  EditProfileView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 14/5/25.
//


import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String

    init(currentName: String) {
        _name = State(initialValue: currentName)
    }

    var body: some View {
        Form {
            Section(header: Text("Nombre")) {
                TextField("Tu nombre", text: $name)
            }

            Section {
                Button("Guardar cambios") {
                    // Aquí podrías guardar al backend
                    dismiss()
                }
                .disabled(name.isEmpty)
            }
        }
        .navigationTitle("Editar perfil")
    }
}
