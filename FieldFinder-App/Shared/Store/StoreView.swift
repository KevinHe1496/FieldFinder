//
//  StoreView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 27/5/25.
//

import StoreKit
import SwiftUI

struct StoreView: View {
    
    enum LoadState {
        case loading, loaded, error
    }
    
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss
    @State private var loadState = LoadState.loading
    @State private var showingPurchaseError = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack {
                    Image(decorative: "unlock")
                        .resizable()
                        .scaledToFit()
                    
                    Text("¡Actualiza hoy!")
                        .font(.title.bold())
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                    
                    Text("Aprovecha al máximo nuestra app")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.blue.gradient)
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // ✅ Card con toda la info y compra
                        VStack(alignment: .leading, spacing: 12) {
                            Text("🎯 Suscripción Premium")
                                .font(.title2.bold())
                            
                            Text("• Publica múltiples canchas y establecimientos.")
                                .font(.subheadline)
                                
                            
                            Text("Duración: 1 mes (renovación automática)")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            
                            if let product = appState.products.first {
                                Button {
                                    purchase(product)
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text(String(format: NSLocalizedString("store_subscribe_button", comment: "Botón de suscripción con precio"), product.displayPrice))
                                            .font(.headline)
                                            .padding()
                                        Spacer()
                                    }
                                    .background(.blue)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                .buttonStyle(.plain)
                            }
                            
                            Divider()
                            
                            Link("📃 Política de privacidad", destination: URL(string: "https://kevinhe1496.github.io/fieldfinder-legal/privacy.html")!)
                                .foregroundStyle(.blue)
                            Link("📄 Términos de uso", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                                .foregroundStyle(.blue)
                        }
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                        
                    }
                    .padding()
                }



                Button("Restaurar compras", action: restore)
                
                Button("Cancelar", role: .cancel) {
                    dismiss()
                }
                .padding(.top, 20)
            }
        }
        .alert("Las compras dentro de la app están deshabilitadas" , isPresented: $showingPurchaseError) {
        } message: {
            Text("""
                No puedes comprar el desbloqueo Premium porque las compras dentro de la app están deshabilitadas en este dispositivo. 
                Por favor, consulta con quien administre tu dispositivo para obtener asistencia.
                """)
        }
        .onChange(of: appState.fullVersionUnlocked) { oldValue, newValue in
            checkForPurchase()
        }
        .task {
            await load()
        }
    }
    
    func checkForPurchase() {
        if appState.fullVersionUnlocked {
            dismiss()
        }
    }
    
    func purchase(_ product: Product) {
        guard AppStore.canMakePayments else {
            showingPurchaseError.toggle()
            return
        }
        
        Task { @MainActor in
            try await appState.purchase(product)
        }
    }
    
    func load() async {
        loadState = .loading
        do {
            try await appState.loadProducts()
            
            if appState.products.isEmpty {
                loadState = .error
            } else {
                loadState = .loaded
            }
        } catch {
            loadState = .error
            print("Failed to load products: \(error.localizedDescription)")
        }
    }
    
    func restore() {
        Task {
            try await AppStore.sync()
        }
    }
}

#Preview {
    StoreView()
        .environment(AppState())
}
