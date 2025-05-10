import SwiftUI
import PhotosUI

struct RegisterOwnerView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImagesData: [Data] = []
    @State private var selectedImageToPreview: Data? = nil
    
    @State private var name = ""
    @State private var info = ""
    @State private var selectedCountry: String = ""
    @State private var address = ""
    @State private var zipcode = ""
    @State private var parqueadero = false
    @State private var vestidores = false
    @State private var bar = false

    var body: some View {
        NavigationStack {
            ScrollView {
                    
                
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
                    //MARK: - Register Form
                    
                    CustomTextFieldLogin(titleKey: "Name", textField: $name, keyboardType: .default, prompt: Text("name"), Bgcolor: .grayColorTF)
                    
                    CustomTextFieldLogin(titleKey: "Info", textField: $info, keyboardType: .default, prompt: Text("info"), Bgcolor: .grayColorTF)
                    


                    CustomTextFieldLogin(titleKey: "País", textField: $selectedCountry, keyboardType: .default, prompt: Text("País"), Bgcolor: .grayColorTF)
                    
                    CustomTextFieldLogin(titleKey: "Dirección", textField: $address, keyboardType: .default, prompt: Text("Dirección"), Bgcolor: .grayColorTF)
                    
                    CustomTextFieldLogin(titleKey: "Codigo Zip", textField: $zipcode, keyboardType: .default, prompt: Text("Codigo Zip"), Bgcolor: .grayColorTF)
                    
                    VStack {
                        
                        Toggle("Parqueadero", isOn: $parqueadero)
                        Divider()
                        Toggle("Vestidores", isOn: $vestidores)
                        
                        Divider()
                        Toggle("Bar", isOn: $bar)
                        
                        Divider()
                        Toggle("Cubierta", isOn: $cubierto)
                        
                    }
                    .padding()
                    .background(.grayColorTF)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    CustomButtonLoginRegister(title: "Registrar", color: .primaryColorGreen, textColor: .white) {
                        
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("REGISTRAR PROPIEDAD")
                        .font(.appTitle)
                        .foregroundStyle(.primaryColorGreen)
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

}

#Preview {
    RegisterOwnerView()
}
