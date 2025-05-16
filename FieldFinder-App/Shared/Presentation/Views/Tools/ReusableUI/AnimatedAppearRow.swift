//
//  AnimatedAppearRow.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 16/5/25.
//


import SwiftUI
// MARK: - Animación de entrada 
struct AnimatedAppearRow<Item: Identifiable, Content: View>: View {
    let item: Item
    @Binding var shownItems: Set<Item.ID>
    let content: () -> Content
    
    var body: some View {
        let isShown = shownItems.contains(item.id)
        
        content()
            .opacity(isShown ? 1 : 0)
            .offset(y: isShown ? 0 : 20)
            .animation(.easeOut(duration: 0.4), value: isShown)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
                    shownItems.insert(item.id)
                }
            }
            .scrollTransition(.animated.threshold(.visible(0.1))) { content, phase in
                content
                    .scaleEffect(phase.isIdentity ? 1 : 0.95)
                    .opacity(phase.isIdentity ? 1 : 0.5)
                    .offset(y: phase.isIdentity ? 0 : 10)
            }
    }
}
