import SwiftUI
import CoreLocation

@available(iOS 18.0, *)
struct PlayerView: View {
    @State private var searchText = ""
    @State private var didLoad = false
    @ObservedObject var viewModel: GetNearbyEstablishmentsViewModel
    
    @State private var shownItems: Set<String> = []
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Encabezado personalizado
                        
                        Text("Todos")
                            .font(.title2.bold())
                            .padding(.horizontal)
                            .padding(.top)
                        
                        // Resultado si hay búsqueda activa
                        if !viewModel.establishmentSearch.isEmpty {
                            Text("Mostrando \(viewModel.filterEstablishments.count) resultados")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        }
                        
                        // Grid con animación
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
            .navigationTitle("Establecimientos")
            .searchable(text: $viewModel.establishmentSearch)
            .task {
                if !didLoad {
                    shownItems = [] // Reinicia animaciones
                    do {
                        try await viewModel.loadData()
                        didLoad = true
                    } catch {
                        print("Error cargando datos: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
}


#Preview {
    PlayerView(viewModel: GetNearbyEstablishmentsViewModel())
}
