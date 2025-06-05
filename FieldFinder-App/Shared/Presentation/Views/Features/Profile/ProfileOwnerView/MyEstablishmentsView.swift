//
//  MyEstablishmentsView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 3/6/25.
//

import SwiftUI

enum OwnerNavigationEstablishmentDestination: Hashable {
    case registerEstablishment
}

struct MyEstablishmentsView: View {
    @Environment(AppState.self) var appState
    let establishment: [EstablishmentResponse]
    @State private var shownItems: Set<String> = []
    @State private var showingStore = false
    @State private var viewModel: OwnerViewModel
    @State private var selectedNavigation: OwnerNavigationEstablishmentDestination?
    let columns = [GridItem(.flexible())]
    
    init(establishment: [EstablishmentResponse], appState: AppState = AppState()) {
        self.establishment = establishment
        _viewModel = State(initialValue: OwnerViewModel(appState: appState))
    }

    var body: some View {
        NavigationStack {
            if establishment.isEmpty {
                ContentUnavailableView("No tienes establecimientos registrados", systemImage: "building.2.crop.circle", description: Text("Empieza a crear un nuevo establecimiento para que tus jugadores lo encuentren fácilmente."))
            }
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(establishment) { establishment in
                        NavigationLink{
                            EstablishmentDetailView(establishmentID: establishment.id)
                        } label: {
                            AnimatedAppearRow(item: establishment, shownItems: $shownItems) {
                                PlayerEstablishmentGridItemView(establishment: establishment)
                            }
                        }
                    }
                }
                
                NavigationLink(
                    destination: RegisterEstablishmentView(appState: appState),
                    tag: .registerEstablishment,
                    selection: $selectedNavigation
                ) {
                    EmptyView()
                }
                .hidden()
                .sheet(isPresented: $showingStore) {
                    StoreView()
                }
            }
            .navigationTitle("Mis Establecimientos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: handleAddFieldTapped) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .accessibilityLabel("Agregar Establecimiento")
                    }
                    .tint(.primaryColorGreen)
                }
            }
        }
    }
    
    private func handleAddFieldTapped() {
        if viewModel.canAddFieldandEstablishment() {
            selectedNavigation = .registerEstablishment
        } else {
            showingStore = true
        }
    }
}

#Preview {
    MyEstablishmentsView(establishment: [.sample])
        .environment(AppState())
}
