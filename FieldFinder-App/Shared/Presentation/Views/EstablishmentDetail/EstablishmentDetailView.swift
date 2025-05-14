//
//  EstablishmentDetailView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import SwiftUI

struct EstablishmentDetailView: View {
    @Environment(\.dismiss) var dismiss
    var establishmentID: String
    
    @State private var viewModel = EstablishmentDetailViewModel()
    
    init(establishmentId: String) {
        self.establishmentID = establishmentId
    }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                //MARK: Photo Gallery
                
                PhotoGalleryView(photoURLs: viewModel.establishmentData.photoEstablishment, height: 300)
                
                //MARK: Informacion
                VStack(alignment: .leading, spacing: 12) {
                    // Detalles del establecimiento
                    Text(viewModel.establishmentData.name)
                        .font(.appTitle)
                        .foregroundStyle(.primaryColorGreen)
                    Divider()
                    HStack {
                        Image(systemName: "pin.fill")
                            .foregroundStyle(.primaryColorGreen)
                        Text(viewModel.establishmentData.address)
                    }
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundStyle(.primaryColorGreen)
                        Text(viewModel.establishmentData.phone)
                    }
                    
                    
                    Divider()
                    Text(viewModel.establishmentData.info)
                        .font(.body)
                    
                    Divider()
                    Text("QUE OFRECE")
                        .font(.appSubtitle)
                        .foregroundStyle(.primaryColorGreen)
                    
                    FacilitiesIconsView(
                        parquedero: viewModel.establishmentData.parquedero,
                        vestidores: viewModel.establishmentData.vestidores,
                        banos: viewModel.establishmentData.banos,
                        duchas: viewModel.establishmentData.duchas,
                        bar: viewModel.establishmentData.bar
                    )
                    
                    
                }
                .padding(.horizontal)
            }
            .task {
                try? await viewModel.getEstablishmentDetail(establishmentId: establishmentID)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.establishmentData.name)
    }
}

#Preview {
    EstablishmentDetailView(establishmentId: "A4537A2F-8810-4AEF-8D0A-1FFAFEEB7747")
}
