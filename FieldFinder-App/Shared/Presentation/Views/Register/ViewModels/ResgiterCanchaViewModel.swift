import Foundation

@MainActor
@Observable
final class RegisterCanchaViewModel {
    
    
    var isLoading = false
    var alertMessage: String?
    var shouldDismissAfterAlert: Bool = false
    
    @ObservationIgnored
    let useCase: RegisterCanchaUseCaseProtocol
    
    init(useCase: RegisterCanchaUseCaseProtocol = RegisterCanchaUseCase()) {
        self.useCase = useCase
    }
    
    
    func registerCancha(_ canchaModel: CanchaRequest, images: [Data]) async {
        
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
            shouldDismissAfterAlert = true
            isLoading = false
        } catch {
            alertMessage = "Error al registrar la cancha"
            isLoading = false
           
            
        }
    }
    
    func editCancha(canchaID: String, canchaModel: CanchaRequest) async throws {
        do {
            let _ = try await useCase.editCancha(canchaID: canchaID, canchaModel: canchaModel)
            alertMessage = "La cancha se ha actualizado correctamente."
        } catch {
            alertMessage = "Ocurrió un error al actualizar la cancha. Intenta nuevamente."
        }
        
    }
    
    func deleteCancha(canchaID: String) async throws {
        do {
            let _ = try await useCase.deleteCancha(canchaID: canchaID)
            alertMessage = "La cancha se ha eliminado correctamente."
            print("Se elimino exitosamente")
        }
    }
    
    func localCurrencySymbol() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.currencySymbol ?? "$"
    }
}
