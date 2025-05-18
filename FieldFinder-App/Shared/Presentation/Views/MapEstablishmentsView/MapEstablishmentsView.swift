//
//  MapEstablishmentsView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//

import SwiftUI
import MapKit

/// Vista principal que muestra un mapa con los establecimientos cercanos.
/// Permite seleccionar un establecimiento, centrar en la ubicación del usuario
/// y ver información detallada en una hoja inferior.
struct MapEstablishmentsView: View {
    
    /// ViewModel que maneja la lógica de establecimientos y ubicación.
    @StateObject var viewModel = GetNearbyEstablishmentsViewModel()

    var body: some View {
        NavigationStack {
            
            // MARK: - Mapa principal con anotaciones
            ZStack(alignment: .bottomTrailing) {
                Map(position: $viewModel.cameraPosition) {
                    
                    // Anotación del usuario
                    UserAnnotation()
                    
                    // Anotaciones para cada establecimiento cercano
                    ForEach(viewModel.nearbyEstablishments) { establishment in
                        Annotation("", coordinate: establishment.coordinate) {
                            Button {
                                // Al tocar una anotación, se selecciona el establecimiento
                                viewModel.selectEstablishment(establishment)
                            } label: {
                                EstablishmentAnnotationView(establishment: establishment)
                            }
                        }
                    }
                }

                .ignoresSafeArea()
                .task {
                    // Carga los datos de establecimientos al aparecer la vista
                    try? await viewModel.loadData()
                }

                // MARK: - Botón para centrar en la ubicación del usuario
                Button {
                    Task {
                        await viewModel.centerOnUserLocation()
                    }
                } label: {
                    Image(systemName: "location.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(Circle().fill(Color.primaryColorGreen))
                        .shadow(radius: 4)
                }
                .padding(.trailing, 16)
                .padding(.bottom, 24)
            }

            // MARK: - Hoja inferior con detalles del establecimiento seleccionado
            .sheet(item: $viewModel.selectedEstablishment) { establishment in
                EstablishmentSelectedMapDestailView(establishment: establishment)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }

            // MARK: - Configuración del título de navegación
            .navigationTitle("Establecimientos cercanos")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MapEstablishmentsView()
}
