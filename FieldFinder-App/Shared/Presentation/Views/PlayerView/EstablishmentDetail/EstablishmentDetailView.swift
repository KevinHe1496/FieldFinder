//
//  EstablishmentDetailView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import SwiftUI
import MapKit

struct EstablishmentDetailView: View {
    @Environment(\.dismiss) var dismiss
    var establishmentID: String
    
    let rows = [GridItem(.fixed(200))]
    
    @State private var viewModel = EstablishmentDetailViewModel()
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var contentVisible = false
    
    init(establishmentId: String) {
        self.establishmentID = establishmentId
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    PhotoGalleryView(photoURLs: viewModel.establishmentData.photoEstablishment, height: 280)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 4)
                        
                    
                    EstablishmentInfoSection(establishment: viewModel.establishmentData)
                    EstablishmentServicesSection(establishment: viewModel.establishmentData)
                    
                    EstablishmentFieldsSection(canchas: viewModel.establishmentData.canchas)
                    EstablishmentMapSection(
                        coordinate: viewModel.establishmentData.coordinate,
                        showAlert: $viewModel.showOpenInMapsAlert,
                        mapsURL: viewModel.mapsURL,
                        prepareMaps: {
                            viewModel.prepareMapsURL(for: viewModel.establishmentData)
                        },
                        cameraPosition: $cameraPosition
                    )
                }
                .padding(.top)
            }
            .animation(.easeInOut(duration: 0.4), value: contentVisible)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.establishmentData.name)
        .task {
            try? await viewModel.getEstablishmentDetail(establishmentId: establishmentID)
            withAnimation {
                contentVisible = true
            }
            let coordinate = viewModel.establishmentData.coordinate
            let region = MKCoordinateRegion(center: coordinate, span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005))
            cameraPosition = .region(region)
        }
    }
}

#Preview {
    EstablishmentDetailView(establishmentId: "A4537A2F-8810-4AEF-8D0A-1FFAFEEB7747")
}
