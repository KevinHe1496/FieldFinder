import SwiftUI
import PhotosUI

struct RegisterOwnerView: View {
    
    @Environment(AppState.self) var appState
    @State private var viewModel: RegisterEstablismentViewModel
    
    
    init(appState: AppState) {
        _viewModel = State(initialValue: RegisterEstablismentViewModel(appState: appState))
    }
    
   
    
    @State private var name = ""
    @State private var info = ""
    @State private var country: String = "Ecuador"
    @State private var address = "Av. Amazonas N34-451 y Av. Atahualpa"
    @State private var city = "Quito"
    @State private var zipcode = "170507"
    @State private var phone = ""
    @State private var parqueadero = false
    @State private var vestidores = false

    
    @State private var bar = false
    @State private var banos = false
    @State private var duchas = false
    @State private var cubierto = false
    
    @State private var selectedImages: [Data] = []
    @State var showAlert: Bool = false
    
    
    var isFormValid: Bool {
        return !name.isEmpty &&
        !info.isEmpty &&
        !address.isEmpty &&
        !country.isEmpty &&
        !city.isEmpty &&
        !zipcode.isEmpty &&
        !phone.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                
                VStack(alignment: .leading, spacing: 16) {
                
                    CustomUIImage(selectedImagesData: $selectedImages)
                    
                    //MARK: - Register Form
                    
                    CustomTextFieldLogin(titleKey: "Name", textField: $name, keyboardType: .default, prompt: Text("name"), Bgcolor: .grayColorTF)
                    
                    CustomTextFieldLogin(titleKey: "Info", textField: $info, keyboardType: .default, prompt: Text("info"), Bgcolor: .grayColorTF)
                    

                    CustomTextFieldLogin(titleKey: "País", textField: $country, keyboardType: .default, prompt: Text("País"), Bgcolor: .grayColorTF)
                    
                    CustomTextFieldLogin(titleKey: "Ciudad", textField: $city, keyboardType: .default, prompt: Text("Ciudad"), Bgcolor: .grayColorTF)
                    
                    CustomTextFieldLogin(titleKey: "Dirección", textField: $address, keyboardType: .default, prompt: Text("Dirección"), Bgcolor: .grayColorTF)
                    
                    CustomTextFieldLogin(titleKey: "Codigo Zip", textField: $zipcode, keyboardType: .default, prompt: Text("Codigo Zip"), Bgcolor: .grayColorTF)
                    
                    CustomTextFieldLogin(titleKey: "Teléfono", textField: $phone, keyboardType: .phonePad, prompt: Text("Teléfono"), Bgcolor: .grayColorTF)
                    
                    VStack {
                        
                        Toggle("Parqueadero", isOn: $parqueadero)
                        Divider()
                        Toggle("Vestidores", isOn: $vestidores)
                        
                        Divider()
                        Toggle("Bar", isOn: $bar)
                        

                        Divider()
                        Toggle("Cubierta", isOn: $cubierto)
                        
                        Divider()
                        Toggle("Baños", isOn: $banos)
                        
                        Divider()
                        Toggle("Duchas", isOn: $duchas)
                        

                    }
                    .padding()
                    .background(.grayColorTF)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    
                    HStack {
                        Spacer()
                        if viewModel.isLoading {
                            ProgressView("Registrando Cancha")
                                .padding()
                        }
                        Spacer()
                    }
                    
                    CustomButtonLoginRegister(title: "Continuar", color: .primaryColorGreen, textColor: .white) {
                        Task {
                            
                            
                            try await viewModel.registerEstablishment(
                                name: name,
                                info: info,
                                address: address,
                                country: country,
                                city: city,
                                zipCode: zipcode,
                                parqueadero: parqueadero,
                                vestidores: vestidores,
                                bar: bar,
                                banos: banos,
                                duchas: duchas,
                                phone: phone,
                                images: selectedImages
                            )
                        }
                    }

                   // .disabled(!isFormValid)
                   // .opacity(isFormValid ? 1 : 0.5)

                }
                .padding()
                
            }
            
            
            
            
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("REGISTRAR PROPIEDAD")
                        .font(.appTitle)
                        .foregroundStyle(.primaryColorGreen)
                }
            }
            .alert("Mensaje", isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(viewModel.alertMessage ?? "")
            }
        }
    }
    
    
    
    
}

#Preview {
    
    RegisterOwnerView(appState: AppState())
        .environment(AppState())
    
}
