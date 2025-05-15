import Foundation
import UIKit

@MainActor
@Observable
final class RegisterEstablismentViewModel {
    
    
    private var appState: AppState
    var isLoading = false
    var showAlert = false
    var latitude: Double?
    var longitude: Double?
    var alertMessage: String?
    @ObservationIgnored
    var useCase: RegisterEstablishmentUseCaseProtocol
    
    init(useCase: RegisterEstablishmentUseCaseProtocol = RegisterEstablishmentUseCase(), appState: AppState) {
        self.useCase = useCase
        self.appState = appState
    }
    

    func registerEstablishment(name: String, info: String, address: String, country: String, city: String, zipCode: String, parqueadero: Bool, vestidores: Bool, bar: Bool, banos: Bool, duchas: Bool, phone: String) async throws {
        
        isLoading = true
        
        guard !address.isEmpty, !info.isEmpty, !country.isEmpty, !city.isEmpty, !zipCode.isEmpty, !name.isEmpty, !phone.isEmpty else {
            self.alertMessage = "Todos los campos son obligatorios. Revisa los datos ingresados."
            showAlert = true
            isLoading = false
            return
        }
        
        do {
            
            let coordinates = try await GeocodingHelper.getCoordinates(
                street: address,
                zipCode: zipCode,
                city: city,
                country: country
            )
            
            print("Coordenadas obtenidas: Latitud: \(coordinates.latitude), Longitud: \(coordinates.longitude)")
            
            self.latitude = coordinates.latitude
            self.longitude = coordinates.longitude
            
            let newModel = EstablishmentModel(
                name: name,
                info: info,
                address: address,
                country: country,
                city: city,
                zipCode: zipCode,
                parqueadero: parqueadero,
                vestidores: vestidores,
                bar: bar,
                banos: banos,
                duchas: duchas,
                latitude: coordinates.latitude,
                longitude: coordinates.longitude,
                phone: phone
            )
            
            try await useCase.registerEstablishment(newModel)
            
            
            alertMessage = "Establecimiento registrado con éxito."
            appState.status = .uploadPhotoEstablishment
        } catch {
            alertMessage = "Error al registrar: \(error.localizedDescription)"
            isLoading = false
            showAlert = true
        }
        
        
       
    }
    
    
    
}
