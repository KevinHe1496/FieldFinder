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
        VStack {
            if !viewModel.establishmentData.photoEstablishment.isEmpty {
                TabView {
                    ForEach(viewModel.establishmentData.photoEstablishment, id: \.self) { photoURL in
                        AsyncImage(url: photoURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 300)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 300)
                                    .clipped()
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 300)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 300)
            } else {
                Text("No hay fotos disponibles")
                    .foregroundColor(.gray)
                // Detalles del establecimiento
                Text(viewModel.establishmentData.name)
                    .font(.title)
                    .padding(.top)
                
                Text(viewModel.establishmentData.info)
                    .font(.body)
                    .padding(.horizontal)
            }
            
        }
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                try await viewModel.getEstablishmentDetail(establishmentId: establishmentID)
            }
        }
    }
}

#Preview {
    EstablishmentDetailView(establishmentId: "")
}
