//
//  FavoriteButton.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//
import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    var onToggle: ((Bool) -> Void)? = nil

    @State private var animate = false
    @State private var internalFavorite: Bool = false

    var body: some View {
        Button(action: {
            internalFavorite.toggle()
            isFavorite = internalFavorite
            animate = true
            onToggle?(internalFavorite)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                animate = false
            }
        }) {
            Image(systemName: internalFavorite ? "heart.fill" : "heart")
                .font(.system(size: 24))
                .foregroundStyle(.red)
                .padding(8)
                .background(Color.white)
                .clipShape(Circle())
                .scaleEffect(animate ? 1.2 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: animate)
        }
        .onAppear {
            internalFavorite = isFavorite
        }
        .onChange(of: isFavorite) { newValue, _ in
            internalFavorite = newValue
        }
    }
}
