import Foundation

final class RegisterCanchaRepository: RegisterCanchaRepositoryProtocol {
   
    
    var network: FieldServiceProtocol
    
    init(network: FieldServiceProtocol = FieldService()) {
        self.network = network
    }
    // GET ID
    func registerCancha(_ canchaModel: CanchaRequest) async throws -> String {
        try await network.createField(canchaModel)
    }
    
    
    
    // UPLOAD IMAGES
    
    func uploadImagesCancha(canchaID: String, images: [Data]) async throws {
        try await network.uploadFieldImages(fieldID: canchaID, images: images)
    }
    
    func editCancha(canchaID: String, canchaModel: CanchaRequest) async throws -> CanchaRequest {
        try await network.updateField(fieldID: canchaID, fieldModel: canchaModel)
    }
    
    func deleteCancha(canchaID: String) async throws {
        try await network.deleteField(fieldID: canchaID)
    }
    
}
