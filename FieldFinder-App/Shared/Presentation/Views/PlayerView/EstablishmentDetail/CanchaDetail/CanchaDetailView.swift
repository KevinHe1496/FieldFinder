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

    @State private var showAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var fieldId = ""
    var userRole: UserRole?
    
    init(fieldId: String, userRole: UserRole? = nil) {
        self.fieldId = fieldId
        self.userRole = userRole
    }
    
    var body: some View {

        NavigationStack {
            ScrollView {
                PhotoGalleryView(photoURLs: viewModel.fieldData.photoCanchas, height: 300)
                VStack(alignment: .leading) {
                    Text("Información:")
                        .font(.appTitle)
                        .foregroundStyle(.primaryColorGreen)
                    Divider()
                    Text("Cancha de: \(viewModel.fieldData.tipo)")
                    Text("Juego de: \(viewModel.fieldData.modalidad)")
                    Text("Precio: $\(viewModel.fieldData.precio) por hora.")
                    
                    Divider()
                    
                    FieldAttributesView(iluminada: viewModel.fieldData.iluminada, cubierta: viewModel.fieldData.cubierta)
                }
                .padding(.horizontal)

            }
            .toolbar {
                if userRole == .dueno {
                                        
                    ToolbarItem {
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
                                .scaledToFit()
                                .frame(height: 30)
                        }
                        
                        .tint(.primaryColorGreen)
                        
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Eliminar", systemImage: "trash.circle.fill") {
                            showAlert = true
                        }
                            .buttonStyle(.plain)
                            .foregroundStyle(.primaryColorGreen)
                            .font(.system(size: 25))
                       }

                }
            }
            .task {
                try? await viewModel.getFieldDetail(with: fieldId)
            }
          
        }
        .alert("Mensaje", isPresented: $showAlert) {
           
            Button("Cancelar", role: .cancel) {}
            
            Button("Eliminar", role: .destructive) {
                Task {
                    try await viewModelRegisterCancha.deleteCancha(canchaID: fieldId)
                }
                dismiss()
            }
            
        } message: {
            Text("Estas seguro de eliminar la cancha?")
        }
    }
}

#Preview {
    CanchaDetailView(fieldId: "", userRole: .dueno)
}
