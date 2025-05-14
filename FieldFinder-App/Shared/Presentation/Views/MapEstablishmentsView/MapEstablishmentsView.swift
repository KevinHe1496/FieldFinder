//
//  MapEstablishmentsView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//

import SwiftUI
import MapKit

struct MapEstablishmentsView: View {
    @StateObject var viewModel = GetNearbyEstablishmentsViewModel()
    var body: some View {
        NavigationStack {
            Map(position: $viewModel.cameraPosition) {
                UserAnnotation()
                
                ForEach(viewModel.nearbyEstablishments) { establishment in
                    Annotation(establishment.name, coordinate: establishment.coordinate) {
                        Button {
                            viewModel.selectEstablishment(establishment)
                        } label: {
                            EstablishmentAnnotationView(establishment: establishment)
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    try await viewModel.loadData()
                }
            }
            .sheet(item: $viewModel.selectedEstablishment) { establishment in
                EstablishmentSelectedMapDestailView(establishment: establishment)
                    .presentationDetents([.medium])
            }
            .mapControls {
                MapCompass()
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            await viewModel.centerOnUserLocation()
                        }
                    } label: {
                        Image(systemName: "location.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Circle()
                                    .fill(.primaryColorGreen)
                                    .frame(width: 32, height: 32)
                            )
                    }
                }
            }
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MapEstablishmentsView()
}
