import Foundation

@MainActor
@Observable
final class RegisterCanchaViewModel {
    
    
    var isLoading = false
    var alertMessage: String?
    
    @ObservationIgnored
    let useCase: RegisterCanchaUseCaseProtocol
    
    init(useCase: RegisterCanchaUseCaseProtocol = RegisterCanchaUseCase()) {
        self.useCase = useCase
    }
    
    
    func registerCancha(_ canchaModel: RegisterCanchaModel, images: [Data]) async {
        
        isLoading = true
        
        guard (canchaModel.precio != 0) else {
            alertMessage = "El campo precio es obligatorio"

            isLoading = false
            return
        }
        
        guard !images.isEmpty else {
            alertMessage = "Es obligatorio subir imágenes"
            
            isLoading = false
            return
        }
        
        
        do {
            let canchaID = try await useCase.registerCancha(canchaModel)
            try await useCase.uploadPhotosCancha(canchaID: canchaID, images: images)
            
            alertMessage = "Cancha registrada con éxito"
           
            isLoading = false
        } catch {
            alertMessage = "Error al registrar la cancha"
            isLoading = false
         
            
        }
    }
    
    
    func localCurrencySymbol() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.currencySymbol ?? "$"
    }
}
