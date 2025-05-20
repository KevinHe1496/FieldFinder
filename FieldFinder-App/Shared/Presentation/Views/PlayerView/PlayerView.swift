import SwiftUI
import CoreLocation


struct PlayerView: View {
    @State private var searchText = ""
    @State private var didLoad = false
    @State private var isLoading = true // 👈 indicador de carga

    @ObservedObject var viewModel: GetNearbyEstablishmentsViewModel
    @State private var shownItems: Set<String> = []
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()

                if isLoading {
                    ProgressView("Cargando establecimientos...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.3)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("Todos")
                                .font(.title2.bold())
                                .padding(.horizontal)
                                .padding(.top)
                            
                            if !viewModel.establishmentSearch.isEmpty {
                                Text("Mostrando \(viewModel.filterEstablishments.count) resultados")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                            }
                            
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(viewModel.filterEstablishments) { establishment in
                                    NavigationLink {
                                        EstablishmentDetailView(establishmentId: establishment.id)
                                    } label: {
                                        AnimatedAppearRow(item: establishment, shownItems: $shownItems, content: {
                                            EstablishmentRowView(establishment: establishment, viewModel: viewModel)
                                        })
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("Establecimientos")
            .searchable(text: $viewModel.establishmentSearch)
            .onAppear {
                Task {
                    do {
                        try await viewModel.loadData()
                        try await viewModel.getFavoritesUser()
                        
                        if !didLoad {
                            shownItems = []
                            didLoad = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                for establishment in viewModel.filterEstablishments {
                                    shownItems.insert(establishment.id)
                                }
                            }
                        }
                        
                        isLoading = false // 👈 Finaliza la carga
                    } catch {
                        print("Error cargando datos: \(error.localizedDescription)")
                        isLoading = false
                    }
                }
            }
        }
    }
}


#Preview {
    PlayerView(viewModel: GetNearbyEstablishmentsViewModel())
}
