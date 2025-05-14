import Foundation

final class RegisterEstablishmentRepository: RegisterEstablismentRepositoryProtocol {
    
    var network: NetworkRegisterEstablishmentProtocol
    
    init(network: NetworkRegisterEstablishmentProtocol = NetworkRegisterEstablishment()) {
        self.network = network
    }
    
    func registerEstablishment(_ establishmentModel: EstablishmentModel) async throws {
        try await network.registerEstablishment(establishmentModel)
    }
    
    
}
