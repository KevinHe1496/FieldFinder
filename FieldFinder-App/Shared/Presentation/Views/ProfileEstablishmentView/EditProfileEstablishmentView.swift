//
//  EditProfileEstablishmentView.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 16/5/25.
//

import SwiftUI

struct EditProfileEstablishmentView: View {
    
    @State var name: String
    @State var info: String
    @State var country: String
    @State var address: String
    @State var city: String
    @State var zipcode: String
    @State var phone: String
    @State var establishmentID: String
    
    @State var parqueadero: Bool
    @State var vestidores: Bool
    @State var bar: Bool
    @State var banos: Bool
    @State var duchas: Bool
    
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: RegisterEstablismentViewModel
     
    init(name: String, info: String, country: String, address: String, city: String, zipcode: String, phone: String, establishmentID: String, parqueadero: Bool, vestidores: Bool, bar: Bool, banos: Bool, duchas: Bool, appState: AppState) {
        
        _viewModel = State(initialValue: RegisterEstablismentViewModel(appState: appState))
        
        self.name = name
        self.info = info
        self.country = country
        self.address = address
        self.city = city
        self.zipcode = zipcode
        self.phone = phone
        self.establishmentID = establishmentID
        self.parqueadero = parqueadero
        self.vestidores = vestidores
        self.bar = bar
        self.banos = banos
        self.duchas = duchas
    }
    
    @State private var showAlert = false
  
    
    var body: some View {
        Form {
            Section {
                TextField("Nombre", text: $name)
                TextField("información", text: $info)
                TextField("País", text: $country)
                TextField("Ciudad", text: $city)
                TextField("Dirección", text: $address)
                TextField("Zipcode", text: $zipcode)
                TextField("Teléfono", text: $phone)
                
                Toggle("Parqueadero", isOn: $parqueadero)
                Toggle("Vestidores", isOn: $vestidores)
                Toggle("Bar", isOn: $bar)
                Toggle("Baños", isOn: $banos)
                Toggle("Duchas", isOn: $duchas)
            } header: {
                Text("Información")
            }

            
            Section {
                Button("Guardar cambios") {
                    showAlert = true
                }
               
            }
        }
        .alert("Mensaje", isPresented: $showAlert) {
           
            
            Button("OK") {
                Task {
                    try await viewModel.editEstablishment(
                        establishmentID: establishmentID,
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
                        phone: phone
                    )
                }
                dismiss()
            }
        } message: {
            Text("Estas seguro de editar tu información?")
        }
    }
}

#Preview {
    EditProfileEstablishmentView(name: "", info: "", country: "", address: "", city: "", zipcode: "", phone: "", establishmentID: "", parqueadero: false, vestidores: true, bar: true, banos: true, duchas: true, appState: AppState())
        .environment(AppState())
}
