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
                if !viewModel.establishmentData.photoEstablishment.isEmpty {
                    ZStack {
                        TabView {
                            ForEach(viewModel.establishmentData.photoEstablishment, id: \.self) { photoURL in
                                AsyncImage(url: photoURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(height: 450)
                                    case .success(let image):
                                        image
                                            .scaledToFit()
                                            .frame(maxWidth: .infinity, maxHeight: 450)
                                            .clipped()
                                            .ignoresSafeArea(edges: .top)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: .infinity, maxHeight: 450)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: 450)
                    }
                } else {
                    Text("No hay fotos disponibles")
                        .foregroundColor(.gray)
                    
                }
                VStack(alignment: .leading, spacing: 5) {
                    // Detalles del establecimiento
                    Text(viewModel.establishmentData.name)
                        .font(.appTitle)
                        .foregroundStyle(.primaryColorGreen)
                        
                    HStack {
                        Image(systemName: "pin.fill")
                            .foregroundStyle(.primaryColorGreen)
                        Text(viewModel.establishmentData.address)
                    }
                    
                    Divider()
                    Text(viewModel.establishmentData.info)
                        .font(.body)
                }
                .padding(.horizontal)
            }
            .onAppear {
                Task {
                    try await viewModel.getEstablishmentDetail(establishmentId: establishmentID)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Circle()
                                    .fill(Color.primaryColorGreen)
                                    .frame(width: 32, height: 32)
                            )
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.container, edges: .top)
    }
}

#Preview {
    EstablishmentDetailView(establishmentId: "A4537A2F-8810-4AEF-8D0A-1FFAFEEB7747")
}
