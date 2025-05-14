//
//  PhotoGalleryView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//


import SwiftUI

struct PhotoGalleryView: View {
    let photoURLs: [URL]
    let height: CGFloat

    var body: some View {
        if !photoURLs.isEmpty {
            TabView {
                ForEach(photoURLs, id: \.self) { photoURL in
                    AsyncImage(url: photoURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: height)
                                .background(.gray)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: height)
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: height)
                                .foregroundColor(.gray.opacity(0.5))
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: height)
        } else {
            Text("No hay fotos disponibles")
                .foregroundColor(.gray)
        }
    }
}
