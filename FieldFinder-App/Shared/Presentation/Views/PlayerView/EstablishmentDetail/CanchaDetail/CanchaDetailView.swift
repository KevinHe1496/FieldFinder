//
//  CanchaDetailView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import SwiftUI

struct CanchaDetailView: View {
    @State private var viewModel = FieldDetailViewModel()
    @State private var viewModelRegisterCancha = RegisterCanchaViewModel()
    @Environment(\.dismiss) var dismiss

    @State private var showAlert: Bool = false
    @State private var contentVisible = false

    var fieldId = ""
    var userRole: UserRole?

    init(fieldId: String, userRole: UserRole? = nil) {
        self.fieldId = fieldId
        self.userRole = userRole
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()

                if contentVisible {
                    ScrollView {
                        VStack(spacing: 20) {
                            PhotoGalleryView(photoURLs: viewModel.fieldData.photoCanchas, height: 280)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 4)
                                .padding(.horizontal)
                                .transition(.opacity.combined(with: .move(edge: .top)))

                            FieldInfoSection(fieldData: viewModel.fieldData)
                            FieldAttributesSection(fieldData: viewModel.fieldData)

                        }
                        .padding(.top)
                        .animation(.easeInOut(duration: 0.4), value: contentVisible)
                    }
                } else {
                    ProgressView("Cargando cancha...")
                }
            }
            .navigationTitle("Detalle de Cancha")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if userRole == .dueno {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                    
                        
                        NavigationLink {
                            EditFieldView(
                                selectedField: Field(rawValue: viewModel.fieldData.tipo) ?? .cesped,
                                selectedCapacidad: Capacidad(rawValue: viewModel.fieldData.modalidad) ?? .cinco,
                                precio: String(viewModel.fieldData.precio),
                                iluminada: viewModel.fieldData.iluminada,
                                cubierta: viewModel.fieldData.cubierta,
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
