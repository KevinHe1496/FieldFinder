//
//  RegisterEstablismentPhotosView.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 14/5/25.
//

import SwiftUI

struct RegisterEstablismentPhotosView: View {
    
    
    @Environment(AppState.self) var appState
    @State private var selectedImages: [Data] = []
    @State private var viewModel: UploadEstablishmentPhotosViewModel
    
    
    init(appState: AppState) {
        _viewModel = State(initialValue: UploadEstablishmentPhotosViewModel(appState: appState))
    }
    
    var body: some View {
        VStack {
            CustomUIImage(selectedImagesData: $selectedImages)
            if !selectedImages.isEmpty {
                Button("Subir fotos") {
                    Task {
                       
                            await viewModel.uploadImages(images: selectedImages)
                        
                    }
                }
                .padding()
                .background(Color.primaryColorGreen)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    RegisterEstablismentPhotosView(appState: AppState())
        .environment(AppState())
}
