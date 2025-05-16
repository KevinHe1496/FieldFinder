import Foundation

final class RegisterCanchaRepository: RegisterCanchaRepositoryProtocol {
   
    
    var network: NetworkRegisterCanchaProtocol
    
    init(network: NetworkRegisterCanchaProtocol = NetworkRegisterCancha()) {
        self.network = network
    }
    // GET ID
    func registerCancha(_ canchaModel: RegisterCanchaModel) async throws -> String {
        try await network.registerCancha(canchaModel)
    }
    
    
    
    // UPLOAD IMAGES
    
    func uploadImagesCancha(canchaID: String, images: [Data]) async throws {
        try await network.uploadImagesCancha(canchaID: canchaID, images: images)
    }
    
    func editCancha(canchaID: String, canchaModel: RegisterCanchaModel) async throws -> RegisterCanchaModel {
        try await network.editCancha(canchaID: canchaID, canchaModel: canchaModel)
    }
    
    func deleteCancha(canchaID: String) async throws {
        try await network.deleteCancha(canchaID: canchaID)
    }
    
}
