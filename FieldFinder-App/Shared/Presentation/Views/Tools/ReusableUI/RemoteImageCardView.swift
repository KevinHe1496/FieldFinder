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
                            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
                            .foregroundColor(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
                    .foregroundColor(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}
