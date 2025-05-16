import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: GetNearbyEstablishmentsViewModel
    @State private var shownItems: Set<String> = []

    var body: some View {
        NavigationStack {
            ZStack {
                // ✅ Fondo plomo suave estilo iOS
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        Text("Mis Favoritos")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top)

                        ForEach(viewModel.favoritesData) { establishment in
                            NavigationLink {
                                EstablishmentDetailView(establishmentId: establishment.id)
                            } label: {
                                AnimatedAppearRow(item: establishment, shownItems: $shownItems) {
                                    FavoriteEstablishmentRowView(
                                        establishment: establishment,
                                        viewModel: viewModel
                                    )
                                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                    .animation(.easeInOut, value: viewModel.favoritesData)
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Favoritos")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task {
                    try? await viewModel.getFavoritesUser()
                }
            }
        }
    }
}

#Preview {
    FavoritesView(viewModel: GetNearbyEstablishmentsViewModel())
}
