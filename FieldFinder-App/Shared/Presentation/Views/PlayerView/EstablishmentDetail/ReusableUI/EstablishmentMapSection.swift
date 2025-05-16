//
//  EstablishmentMapSection.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 16/5/25.
//


import SwiftUI
import MapKit

struct EstablishmentMapSection: View {
    let coordinate: CLLocationCoordinate2D
    @Binding var showAlert: Bool
    let mapsURL: URL?
    let prepareMaps: () -> Void
    @Binding var cameraPosition: MapCameraPosition

    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Ubicación")
                    .font(.headline)
                    .foregroundColor(.primaryColorGreen)

                Map(position: $cameraPosition) {
                    Annotation("Ubicación", coordinate: coordinate) {
                        Image(.logoFieldfinderTransparent)
                            .resizable()
                    }
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .onTapGesture {
                    prepareMaps()
                }
            }
        }
        .alert("¿Abrir en Apple Maps?", isPresented: $showAlert) {
            Button("Abrir") {
                if let url = mapsURL {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancelar", role: .cancel) { }
        } message: {
            Text("Esto te llevará a la app Maps para ver la ubicación.")
        }
    }
}
