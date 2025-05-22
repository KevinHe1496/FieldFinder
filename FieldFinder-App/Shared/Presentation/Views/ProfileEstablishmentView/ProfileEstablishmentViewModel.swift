import Foundation

@MainActor
@Observable
final class ProfileEstablishmentViewModel {
    @ObservationIgnored
    var useCase: EstablishmentServiceUseCase
    
    init(useCase: EstablishmentServiceUseCase = EstablishmentServiceUseCase()) {
        self.useCase = useCase
    }
    
    func editEstablishment(establishmentID: String, establishmentModel: EstablishmentRequest) async throws {
        
    }
}
