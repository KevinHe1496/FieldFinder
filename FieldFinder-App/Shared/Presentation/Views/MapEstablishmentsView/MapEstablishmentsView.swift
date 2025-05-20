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
import SwiftUI
import MapKit

struct MapEstablishmentsView: View {
    
    @StateObject var viewModel = GetNearbyEstablishmentsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Contenido dinámico por estado
                switch viewModel.status {
                case .idle, .loading:
                    ProgressView("Cargando...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.3)
                    
                case .success(let establecimientos):
                    ZStack(alignment: .bottomTrailing) {
                        // Mapa con anotaciones
                        Map(position: $viewModel.cameraPosition) {
                            UserAnnotation()
                            ForEach(establecimientos) { establishment in
                                Annotation("", coordinate: establishment.coordinate) {
                                    Button {
                                        viewModel.selectEstablishment(establishment)
                                    } label: {
                                        EstablishmentAnnotationView(establishment: establishment)
                                    }
                                }
                            }
                        }
                        .ignoresSafeArea()
                        .toolbarBackground(Color(UIColor.systemGroupedBackground), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarBackground(Color(UIColor.systemGroupedBackground), for: .tabBar)
                        .toolbarBackground(.visible, for: .tabBar)
                        
                        // Botón para centrar en la ubicación
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
                    
                case .error(let message):
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.primaryColorGreen)
                        Text("Error al cargar el mapa")
                            .font(.headline)
                        Text(message)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }
            .task {
                try? await viewModel.loadData()
            }
            .sheet(item: $viewModel.selectedEstablishment) { establishment in
                EstablishmentSelectedMapDestailView(establishment: establishment)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
            .navigationTitle("Establecimientos cercanos")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MapEstablishmentsView()
}
