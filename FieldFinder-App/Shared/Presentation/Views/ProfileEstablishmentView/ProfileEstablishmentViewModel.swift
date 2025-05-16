import Foundation

@MainActor
@Observable
final class ProfileEstablishmentViewModel {
    @ObservationIgnored
    var useCase: RegisterEstablishmentUseCase
    
    init(useCase: RegisterEstablishmentUseCase = RegisterEstablishmentUseCase()) {
        self.useCase = useCase
    }
    
    func editEstablishment(establishmentID: String, establishmentModel: EstablishmentModel) async throws {
        
    }
}
