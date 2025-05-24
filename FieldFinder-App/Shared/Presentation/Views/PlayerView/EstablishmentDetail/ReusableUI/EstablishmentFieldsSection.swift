//
//  EstablishmentFieldsSection.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 16/5/25.
//


import SwiftUI

struct EstablishmentFieldsSection: View {
    let canchas: [FieldResponse]
    @State private var shownItems: Set<String> = []
    let rows = GridItem(.flexible(minimum: 80))

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Canchas")
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .foregroundStyle(.primaryColorGreen)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [rows]) {
                        ForEach(canchas) { cancha in
                            NavigationLink {
                                CanchaDetailView(fieldId: cancha.id)
                            } label: {
                                AnimatedAppearRow(item: cancha, shownItems: $shownItems) {
                                    CanchaRowView(cancha: cancha)
                                        .frame(width: UIScreen.main.bounds.width * 1, height: 350)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(.thirdColorWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    EstablishmentFieldsSection(canchas: [.sample])
}
