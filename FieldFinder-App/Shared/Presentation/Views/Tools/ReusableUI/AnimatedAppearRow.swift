//
//  AnimatedAppearRow.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 16/5/25.
//

import SwiftUI

/// Vista reutilizable que anima la aparición de un ítem cuando entra en pantalla.
@available(iOS 18.0, *)
struct AnimatedAppearRow<Item: Identifiable, Content: View>: View {
    let item: Item
    @Binding var shownItems: Set<Item.ID>
    let content: () -> Content

    var body: some View {
        let isShown = shownItems.contains(item.id)

        content()
            .opacity(isShown ? 1 : 0.01) // En lugar de 0, usa un valor bajo para evitar que desaparezca totalmente
            .offset(y: isShown ? 0 : 12)
            .animation(.smooth(duration: 0.35), value: isShown)
            .onAppear {
                guard !shownItems.contains(item.id) else { return }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation {
                       _ = shownItems.insert(item.id)
                    }
                }
            }

            .scrollTransition(.animated.threshold(.visible(0.1))) { content, phase in
                content
                    .scaleEffect(phase.isIdentity ? 1 : 0.96)
                    .opacity(phase.isIdentity ? 1 : 0.4)
                    .offset(y: phase.isIdentity ? 0 : 8)
            }
    }
}

