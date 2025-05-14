//
//  RemoteImageCardView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//


import SwiftUI

struct RemoteImageCardView: View {
    let url: URL?
    let height: CGFloat
    
    var body: some View {
        Group {
            if let imageURL = url {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .frame(height: height)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill() // <-- Rellena todo el espacio disponible
                            .frame(maxWidth: .infinity)
                            .frame(height: height)
                            .clipped() // <-- Recorta el exceso
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        VStack {
                            Text("No se pudo cargar la foto")
                        }
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                VStack {
                    Text("No hay fotos disponibles")
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}
