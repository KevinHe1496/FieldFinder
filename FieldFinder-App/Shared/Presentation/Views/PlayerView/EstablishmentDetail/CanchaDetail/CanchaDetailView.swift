//
//  CanchaDetailView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import SwiftUI

struct CanchaDetailView: View {
    @State private var viewModel = FieldDetailViewModel()
    var fieldId = ""
    
    init(fieldId: String) {
        self.fieldId = fieldId
    }
    
    var body: some View {
        ScrollView {
            PhotoGalleryView(photoURLs: viewModel.fieldData.photoCanchas, height: 300)
            VStack(alignment: .leading) {
                Text("Información:")
                    .font(.appTitle)
                    .foregroundStyle(.primaryColorGreen)
                Divider()
                Text("Cancha:  \(viewModel.fieldData.tipo)")
                Text("Juego:  \(viewModel.fieldData.modalidad)")
                Text("Precio: $\(viewModel.fieldData.precio) por hora.")
                
                Divider()
                
                FieldAttributesView(iluminada: viewModel.fieldData.iluminada, cubierta: viewModel.fieldData.cubierta)
            }
            .padding(.horizontal)
        }
        .task {
            try? await viewModel.getFieldDetail(with: fieldId)
        }
    }
}

#Preview {
    CanchaDetailView(fieldId: "")
}
