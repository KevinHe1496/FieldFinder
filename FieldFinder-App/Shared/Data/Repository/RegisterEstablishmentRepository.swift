import Foundation

final class RegisterEstablishmentRepository: RegisterEstablismentRepositoryProtocol {
    
    
    
    var network: NetworkRegisterEstablishmentProtocol
    
    init(network: NetworkRegisterEstablishmentProtocol = NetworkRegisterEstablishment()) {
        self.network = network
    }
    
    func registerEstablishment(_ establishmentModel: EstablishmentModel) async throws -> String {
        try await network.registerEstablishment(establishmentModel)
    }
    
 
    // Upload Images
    
    func uploadImages(establishmentID: String, images: [Data]) async throws {
        try await network.uploadImages(establishmentID: establishmentID, images: images)
    }
    
}
