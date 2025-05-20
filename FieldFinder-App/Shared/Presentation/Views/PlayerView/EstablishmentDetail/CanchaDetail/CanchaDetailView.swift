//
//  CanchaDetailView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import SwiftUI

import SwiftUI

struct CanchaDetailView: View {
    @State private var viewModel = FieldDetailViewModel()
    @State private var viewModelRegisterCancha = RegisterCanchaViewModel()
    @Environment(\.dismiss) var dismiss

    @State private var showAlert: Bool = false
    @State private var contentVisible = false

    var fieldId: String
    var userRole: UserRole?

    init(fieldId: String, userRole: UserRole? = nil) {
        self.fieldId = fieldId
        self.userRole = userRole
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()

                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("Cargando cancha...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.2)

                case .success(let cancha):
                    ScrollView {
                        VStack(spacing: 20) {
                            PhotoGalleryView(photoURLs: cancha.photoCanchas, height: 280)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 4)
                                .padding(.horizontal)
                                .transition(.opacity.combined(with: .move(edge: .top)))

                            FieldInfoSection(fieldData: cancha)
                            FieldAttributesSection(fieldData: cancha)
                        }
                        .padding(.top)
                        .animation(.easeInOut(duration: 0.4), value: contentVisible)
                    }

                case .error(let errorMessage):
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.orange)
                        Text("Error al cargar la cancha")
                            .font(.headline)
                        Text(errorMessage)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }
            .navigationTitle("Detalle de Cancha")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if case .success(let cancha) = viewModel.state, userRole == .dueno {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink {
                            EditFieldView(
                                selectedField: Field(rawValue: cancha.tipo) ?? .cesped,
                                selectedCapacidad: Capacidad(rawValue: cancha.modalidad) ?? .cinco,
                                precio: String(cancha.precio),
                                iluminada: cancha.iluminada,
                                cubierta: cancha.cubierta,
                                canchaID: fieldId
                            )
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.primaryColorGreen)
                        }

                        Button {
                            showAlert = true
                        } label: {
                            Image(systemName: "trash.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.primaryColorGreen)
                        }
                    }
                }
            }
            .task {
                try? await viewModel.getFieldDetail(with: fieldId)
                withAnimation {
                    contentVisible = true
                }
            }
            .alert("Mensaje", isPresented: $showAlert) {
                Button("Cancelar", role: .cancel) {}
                Button("Eliminar", role: .destructive) {
                    Task {
                        try await viewModelRegisterCancha.deleteCancha(canchaID: fieldId)
                        dismiss()
                    }
                }
            } message: {
                Text("¿Estás seguro de eliminar esta cancha?")
            }
        }
    }
}




#Preview {
    CanchaDetailView(fieldId: "", userRole: .dueno)
}
