import SwiftUI
import PhotosUI
import TipKit

struct RegisterEstablishmentView: View {
    
    @Environment(AppState.self) var appState
    @State private var viewModel: RegisterEstablismentViewModel
    
    let coverTip = CoverImageTip()
    
    
    init(appState: AppState) {
        _viewModel = State(initialValue: RegisterEstablismentViewModel(appState: appState))
    }
    
    @State private var name = ""
    @State private var info = ""
    @State private var country: String = "Estados Unidos"
    @State private var address = "10800 Torre Avenue"
    @State private var city = "Cupertino"
    @State private var zipcode = "95014"
    @State private var phone = ""
    @State private var parqueadero = false
    @State private var vestidores = false
    
    
    @State private var bar = false
    @State private var banos = false
    @State private var duchas = false
    @State private var cubierto = false
    
    @State private var selectedImages: [Data] = []
    @State var showAlert: Bool = false
    @State var showingStore = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                
                VStack(alignment: .leading, spacing: 16) {
                    TipView(coverTip, arrowEdge: .bottom)
                    CustomUIImage(selectedImagesData: $selectedImages)
                    
                        .padding(.bottom,8)
                    
                    //MARK: - Register Form
                    
                    CustomTextFieldLogin(titleKey: "Nombre", textField: $name, keyboardType: .default, prompt: Text("Nombre"), colorBackground: Color(.secondarySystemBackground))
                        .autocorrectionDisabled(true)
                    
                    CustomTextFieldLogin(titleKey: "Información", textField: $info, keyboardType: .default, prompt: Text("Información"), colorBackground: Color(.secondarySystemBackground))
                        
                    
                    CustomTextFieldLogin(titleKey: "País", textField: $country, keyboardType: .default, prompt: Text("País"), colorBackground: Color(.secondarySystemBackground))
                        
                    
                    CustomTextFieldLogin(titleKey: "Ciudad", textField: $city, keyboardType: .default, prompt: Text("Ciudad"), colorBackground: Color(.secondarySystemBackground))
                    
                    CustomTextFieldLogin(titleKey: "Dirección", textField: $address, keyboardType: .default, prompt: Text("Dirección"), colorBackground: Color(.secondarySystemBackground))
                        .autocorrectionDisabled(true)
                    
                    CustomTextFieldLogin(titleKey: "Codigo Zip", textField: $zipcode, keyboardType: .default, prompt: Text("Codigo Zip"), colorBackground: Color(.secondarySystemBackground))
                    
                    CustomTextFieldLogin(titleKey: "Teléfono", textField: $phone, keyboardType: .phonePad, prompt: Text("Teléfono"), colorBackground: Color(.secondarySystemBackground))
                    
                    
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
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.primaryColorGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        CustomButtonView(title: "Continuar", color: .primaryColorGreen, textColor: .white) {
                            
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
                                showAlert = true
                            }
                            
                        }
                        .sheet(isPresented: $showingStore) {
                            StoreView()
                                .environment(appState)
                        }
                    }
                    
                }
                .padding()
                
            }
            .task {
                // Configure and load your tips at app launch.
                do {
                    try Tips.configure()
                }
                catch {
                    // Handle TipKit errors
                    print("Error initializing TipKit \(error.localizedDescription)")
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
            .alert("Mensaje", isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(viewModel.alertMessage ?? "")
            }
        }
    }
}

#Preview {
    
    RegisterEstablishmentView(appState: AppState())
        .environment(AppState())
    
}
