//
//  EstablishmentFieldsSection.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 16/5/25.
//


import SwiftUI

struct EstablishmentFieldsSection: View {
    let canchas: [Cancha]
    @State private var shownItems: Set<String> = []

    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Canchas")
                    .font(.headline)
                    .foregroundColor(.primaryColorGreen)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.fixed(200))]) {
                        ForEach(canchas) { cancha in
                            NavigationLink {
                                CanchaDetailView(fieldId: cancha.id)
                            } label: {
                                AnimatedAppearRow(item: cancha, shownItems: $shownItems) {
                                    CanchaRowView(cancha: cancha)
                                        .frame(width: UIScreen.main.bounds.width * 0.8)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .shadow(radius: 2)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .frame(height: 300)
                }
            }
        }
    }
}
