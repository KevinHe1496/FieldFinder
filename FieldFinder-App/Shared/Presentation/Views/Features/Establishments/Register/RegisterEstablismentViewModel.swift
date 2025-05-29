import Foundation
import UIKit


@Observable
final class RegisterEstablismentViewModel {
    
    
    private var appState: AppState
    var isLoading = false
    var latitude: Double?
    var longitude: Double?
    var alertMessage: String?
    @ObservationIgnored
    var useCase: EstablishmentServiceUseCaseProtocol
    
    init(useCase: EstablishmentServiceUseCaseProtocol = EstablishmentServiceUseCase(), appState: AppState) {
        self.useCase = useCase
        self.appState = appState
    }
    
    @MainActor
    func registerEstablishment(name: String, info: String, address: String, country: String, city: String, zipCode: String, parqueadero: Bool, vestidores: Bool, bar: Bool, banos: Bool, duchas: Bool, phone: String, images: [Data]) async throws {
        
        isLoading = true
        
        
     
        
        guard !address.isEmpty, !info.isEmpty, !country.isEmpty, !city.isEmpty, !zipCode.isEmpty, !name.isEmpty, !phone.isEmpty else {
            self.alertMessage = "Todos los campos son obligatorios. Revisa los datos ingresados."
            isLoading = false
            return
        }
        
        guard !images.isEmpty else {
            alertMessage = "Es obligatorio subir imágenes."
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
            
            let newModel = EstablishmentRequest(
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
            
            let establismentID = try await useCase.createEstablishment(newModel)
            try await useCase.uploadEstablishmentImages(establishmentID: establismentID, images: images)
            
            
            alertMessage = "Establecimiento registrado con éxito."
            appState.status = .home
        } catch {
            alertMessage = "Error al registrar: \(error.localizedDescription)"
            isLoading = false
        }
        
        
        
    }
    
    @MainActor
    func editEstablishment(establishmentID: String, name: String, info: String, address: String, country: String, city: String, zipCode: String, parqueadero: Bool, vestidores: Bool, bar: Bool, banos: Bool, duchas: Bool, phone: String)  async throws {
        
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
            
            let newModel = EstablishmentRequest(
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
            
          
            
            try await useCase.updateEstablishment(establishmentID: establishmentID, establishmentModel: newModel)
            
            
            alertMessage = "Establecimiento registrado con éxito."
        } catch {
            print("Error al registrar: \(error.localizedDescription)")
            isLoading = false
        }
        
        
    }
    
    
    
}
