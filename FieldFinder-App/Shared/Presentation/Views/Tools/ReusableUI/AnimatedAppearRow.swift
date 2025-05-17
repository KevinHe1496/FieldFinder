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
        let isShown = shownItems.contains(item.id) // Verifica si este ítem ya fue mostrado antes

        content()
            .opacity(isShown ? 1 : 0) // Si ya apareció, opacidad normal; si no, invisible
            .offset(y: isShown ? 0 : 12) // Aplica desplazamiento para dar sensación de aparición
            .animation(.smooth(duration: 0.35), value: isShown) // Anima suavemente cuando cambia isShown
            .onAppear {
                // Cuando el ítem aparece por primera vez, lo marcamos como mostrado con animación
                if !isShown {
                    withAnimation {
                        _ = shownItems.insert(item.id)
                    }
                }
            }
            .scrollTransition(.animated.threshold(.visible(0.1))) { content, phase in
                // Aplica una animación cuando el usuario hace scroll y el ítem entra o sale de pantalla
                content
                    .scaleEffect(phase.isIdentity ? 1 : 0.96)
                    .opacity(phase.isIdentity ? 1 : 0.4)
                    .offset(y: phase.isIdentity ? 0 : 8)
            }
    }
}
