//
//  RemoteImageCardView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//


import SwiftUI

struct RemoteImageCardView: View {
    let url: URL?

    var body: some View {
        Group {
            if let imageURL = url {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(minWidth: 350)
                            .frame(height: 240)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 240)
                            .frame(minWidth: 250)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                    case .failure:
                        VStack {
                            Text("No se pudo cargar la foto")
                        }
                        .frame(minWidth: 250)
                        .frame(height: 240)
                        .foregroundStyle(.gray)
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
                .frame(minWidth: 250)
                .frame(height: 240)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

#Preview {
    RemoteImageCardView(url: URL(string: "https://fieldfinder-uploads.s3.us-east-2.amazonaws.com/cancha/6E1285EF-35F3-4A85-BC8B-689C1E001404-image0.jpg"))
}
