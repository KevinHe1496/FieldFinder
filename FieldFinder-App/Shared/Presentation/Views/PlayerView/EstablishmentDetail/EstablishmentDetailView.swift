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
    
    // Define la altura de la fila para las canchas
    let rows = [
        GridItem(.fixed(200))
    ]
    
    // ViewModel con los datos del establecimiento
    @State private var viewModel = EstablishmentDetailViewModel()
    
    // Posición de la cámara del mapa
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    init(establishmentId: String) {
        self.establishmentID = establishmentId
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // Galería de fotos del establecimiento
                PhotoGalleryView(photoURLs: viewModel.establishmentData.photoEstablishment, height: 300)
                
                VStack(alignment: .leading, spacing: 12) {
                    // Nombre del establecimiento
                    Text(viewModel.establishmentData.name)
                        .font(.appTitle)
                        .foregroundStyle(.primaryColorGreen)
                    
                    Divider()
                    
                    // Dirección
                    HStack {
                        Image(systemName: "pin.fill")
                            .foregroundStyle(.primaryColorGreen)
                        Text(viewModel.establishmentData.address)
                    }
                    
                    // Teléfono
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundStyle(.primaryColorGreen)
                        Text(viewModel.establishmentData.phone)
                    }
                    
                    Divider()
                    
                    // Información general
                    Text(viewModel.establishmentData.info)
                        .font(.body)
                    
                    Divider()
                    
                    // Servicios disponibles
                    Text("Servicios disponibles")
                        .font(.appSubtitle)
                        .foregroundStyle(.primaryColorGreen)
                    
                    FacilitiesIconsView(
                        parquedero: viewModel.establishmentData.parquedero,
                        vestidores: viewModel.establishmentData.vestidores,
                        banos: viewModel.establishmentData.banos,
                        duchas: viewModel.establishmentData.duchas,
                        bar: viewModel.establishmentData.bar
                    )
                    
                    Divider()
                    
                    // Lista horizontal de canchas
                    Text("Canchas")
                        .font(.appSubtitle)
                        .foregroundStyle(.primaryColorGreen)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows) {
                            ForEach(viewModel.establishmentData.canchas) { cancha in
                                NavigationLink {
                                    CanchaDetailView(fieldId: cancha.id)
                                } label: {
                                    CanchaRowView(cancha: cancha)
                                        .frame(width: UIScreen.main.bounds.width * 0.8)
                                }
                            }
                        }
                        .frame(height: 300)
                    }
                    .scrollIndicators(.hidden)
                    
                    // Mapa con ubicación del establecimiento
                    Divider()
                    Text("Ubicación")
                        .font(.appSubtitle)
                        .foregroundStyle(.primaryColorGreen)
                    
                    VStack {
                        Map(position: $cameraPosition) {
                            Annotation("Ubicación", coordinate: viewModel.establishmentData.coordinate) {
                                Image(.logoFieldfinderTransparent)
                                    .resizable()
                            }
                        }
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }
                    .onTapGesture {
                        viewModel.prepareMapsURL(for: viewModel.establishmentData)
                    }

                    .padding(.bottom)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .alert("¿Abrir en Apple Maps?", isPresented: $viewModel.showOpenInMapsAlert) {
                        Button("Abrir", role: .none) {
                            if let url = viewModel.mapsURL {
                                UIApplication.shared.open(url)
                            }
                        }
                        Button("Cancelar", role: .cancel) { }
                    } message: {
                        Text("Esto te llevará a la app Maps para ver la ubicación.")
                    }

                }
                .padding(.horizontal)
            }
            .task {
                try? await viewModel.getEstablishmentDetail(establishmentId: establishmentID)
                
                let coordinate = viewModel.establishmentData.coordinate
                let region = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                )
                cameraPosition = .region(region)
            }
        }
        // Configura el título del navigation bar
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.establishmentData.name)
    }
}


#Preview {
    EstablishmentDetailView(establishmentId: "A4537A2F-8810-4AEF-8D0A-1FFAFEEB7747")
}
