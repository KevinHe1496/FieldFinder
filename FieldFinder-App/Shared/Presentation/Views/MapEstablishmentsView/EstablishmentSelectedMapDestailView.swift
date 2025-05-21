//
//  EstablishmentSelectedMapDestailView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 14/5/25.
//

import SwiftUI
import MapKit

struct EstablishmentSelectedMapDestailView: View {
    @Environment(\.dismiss) var dismiss
    let establishment: Establecimiento
    @State private var viewModel = EstablishmentDetailViewModel()
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Imagen destacada
                AsyncImage(url: establishment.photoEstablishment.first) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(16)
                        .shadow(radius: 4)
                } placeholder: {
                    ProgressView()
                        .frame(height: 220)
                }

                // Nombre
                Text(establishment.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primaryColorGreen)
                    .padding(.horizontal)

                // Información
                if !establishment.info.isEmpty {
                    Text(establishment.info)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Teléfono
                if !establishment.phone.isEmpty {
                    HStack(spacing: 12) {
                        Image(systemName: "phone.fill")
                            .foregroundStyle(.primaryColorGreen)
                        Text(establishment.phone)
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                // Botón de ubicación
                HStack(spacing: 12) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Circle().fill(Color.primaryColorGreen))
                        .shadow(radius: 4)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ir a la dirección")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(establishment.address)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }

                    Spacer()
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .shadow(radius: 1)
                .padding(.horizontal)
                .onTapGesture {
                    Task {
                        viewModel.prepareMapsURL(for: establishment)
                    }
                }

                // Botón Cancelar
                CustomButtonView(title: "Cancelar", color: .primaryColorGreen, textColor: .thirdColorWhite) {
                    dismiss()
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .alert("¿Abrir en Apple Maps?", isPresented: $viewModel.showOpenInMapsAlert) {
            Button("Abrir", role: .none) {
                Task {
                    viewModel.openMapsURL()
                }
            }
            Button("Cancelar", role: .cancel) { }
        } message: {
            Text("Esto abrirá la app Mapas con la ubicación del establecimiento.")
        }
    }
}


#Preview {
    EstablishmentSelectedMapDestailView(establishment: .sample)
}
