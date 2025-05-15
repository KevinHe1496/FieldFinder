import Foundation

@MainActor
@Observable
final class UploadEstablishmentPhotosViewModel {
    @ObservationIgnored
    private let useCase: UploadPhotosEstablishmentUseCaseProtocol
    @ObservationIgnored
    private var appState: AppState
    
    // Puedes usar esto para mostrar feedback en la UI
    var isUploading = false
    var uploadSuccess = false
    var errorMessage: String? = nil
    
    init(useCase: UploadPhotosEstablishmentUseCaseProtocol = UploadPhotosEstablishmentUseCase(), appState: AppState) {
        self.useCase = useCase
        self.appState = appState
    }
    
    func uploadImages(images: [Data]) async {
        isUploading = true
        errorMessage = nil
        
        do {
            let response = try await GetMeUseCase().getUser()
            
            if let idStablisment = response.establecimiento.first?.id {
                try await useCase.uploadImages(establishmentID: idStablisment, images: images)
                
                uploadSuccess = true
                self.appState.status = .ownerView
            }
            
            
            
        } catch {
            errorMessage = "Error al subir las imágenes: \(error.localizedDescription)"
            uploadSuccess = false
        }
        isUploading = false
    }
}
