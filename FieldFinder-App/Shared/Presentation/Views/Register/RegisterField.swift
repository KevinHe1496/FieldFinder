//
//  Field.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 9/5/25.
//


import SwiftUI
import PhotosUI

enum Field: String, CaseIterable, Identifiable {
    case cesped = "Cesped"
    case sintetico = "Sintético"
    
    var id: String { self.rawValue }
}

enum Capacidad: String, CaseIterable, Identifiable {
    case cinco = "5-5"
    case siete = "7-7"
    case nueve = "9-9"
    case once = "11-11"
    
    var id: String { self.rawValue }
}

struct RegisterField: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImagesData: [Data] = []
    @State private var selectedImageToPreview: Data? = nil
    
    @State private var selectedField: Field = .cesped
    @State private var selectedCapacidad: Capacidad = .cinco
    @State private var precio = ""
    @State private var iluminada = false
    @State private var cubierta = false
    
    let localCurrency = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        ScrollView {
            Text("REGISTRAR CANCHA")
                .font(.appTitle)
                .foregroundStyle(.primaryColorGreen)
            VStack(alignment: .leading, spacing: 16) {
                Text("Añadir fotografías:")
                    .font(.appSubtitle)
                
                if selectedImagesData.count < 12 {
                    PhotosPicker(
                        selection: $selectedItems,
                        maxSelectionCount: 12 - selectedImagesData.count,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 24))
                                .foregroundStyle(.primaryColorGreen)
                            Text("Seleccionar fotos")
                                .foregroundStyle(.primaryColorGreen)
                        }
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .onChange(of: selectedItems) { newItems, _ in
                        Task {
                            for item in newItems {
                                if let originalData = try? await item.loadTransferable(type: Data.self),
                                   let resizedData = resizeImageData(from: originalData){
                                    if selectedImagesData.count < 12 {
                                        selectedImagesData.append(resizedData)
                                    }
                                }
                            }
                            selectedItems = []
                        }
                    }
                }
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(Array(selectedImagesData.enumerated()), id: \.offset) { index, imageData in
                        if let uiImage = UIImage(data: imageData) {
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .onTapGesture {
                                        selectedImageToPreview = imageData
                                    }
                                
                                Button {
                                    selectedImagesData.remove(at: index)
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.red)
                                        .background(Color.white.clipShape(Circle()))
                                }
                                .offset(x: -5, y: 5)
                            }
                        }
                    }
                    
                }
                
                VStack {
                    HStack {
                        Text("Cancha")
                        Spacer()
                        Picker("Selecciona la cancha", selection: $selectedField) {
                            ForEach(Field.allCases) { cancha in
                                Text(cancha.rawValue)
                                    .tag(cancha)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Divider()
                    HStack {
                        Text("Capacidad")
                        Spacer()
                        Picker("Selecciona modalidad", selection: $selectedCapacidad) {
                            ForEach(Capacidad.allCases) { capacidad in
                                Text(capacidad.rawValue)
                                    .tag(capacidad)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Divider()
                    Toggle("Iluminada", isOn: $iluminada)
                    
                    Divider()
                    Toggle("Cubierta", isOn: $cubierta)
                }
                .padding()
                .background(.grayColorTF)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                //MARK: PRECIO
                HStack {
                    Text("Precio por hora")
                    Spacer()
                    HStack {
                        Text(localCurrencySymbol())
                            .foregroundStyle(.secondary)
                        TextField("0.00", text: $precio)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding()
                .background(.grayColorTF)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                
                CustomButtonLoginRegister(title: "Registrar", color: .primaryColorGreen, textColor: .thirdColorWhite) {
                    
                }
            }
            .padding()
        }
        .fullScreenCover(isPresented: Binding<Bool>(
            get: { selectedImageToPreview != nil },
            set: { newValue in
                if !newValue { selectedImageToPreview = nil }
            })
        ) {
            if let imageData = selectedImageToPreview,
               let uiImage = UIImage(data: imageData) {
                ZStack(alignment: .topTrailing) {
                    Color.black.ignoresSafeArea()

                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .background(Color.black)

                    Button {
                        selectedImageToPreview = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
            }
        }
    }
    func resizeImageData(from data: Data, maxDimension: CGFloat = 800, compressionQuality: CGFloat = 0.5) -> Data? {
        guard let image = UIImage(data: data) else { return nil }

        // 1. Calcular nuevo tamaño proporcional
        let size = image.size
        let ratio = min(maxDimension / size.width, maxDimension / size.height)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        // 2. Redibujar imagen
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }

        // 3. Comprimir como JPEG
        return resizedImage.jpegData(compressionQuality: compressionQuality)
    }
    
    func localCurrencySymbol() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.currencySymbol ?? "$"
    }
}

#Preview {
    RegisterField()
}
