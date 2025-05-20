import SwiftUI
import CoreLocation


struct PlayerView: View {
    @State private var searchText = ""
    @State private var didLoad = false
    
    @ObservedObject var viewModel: GetNearbyEstablishmentsViewModel
    @State private var shownItems: Set<String> = []
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.status {
                case .idle, .loading:
                    ProgressView("Cargando...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.3)
                    
                case .success:
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
                    .background(Color(UIColor.systemGroupedBackground))
                    
                    
                case .error(let message):
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.primaryColorGreen)
                        Text("Error al cargar los establecimientos")
                            .font(.headline)
                        Text(message)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding()
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
                    }
                }
            }
        }
    }
}

#Preview {
    PlayerView(viewModel: GetNearbyEstablishmentsViewModel())
}
