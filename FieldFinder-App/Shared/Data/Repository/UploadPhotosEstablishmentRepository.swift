import Foundation


final class UploadPhotosEstablishmentRepository: UploadPhotosEstablishmentRepositoryProtocol {
    
    var network: NetworkUploadPhotosEstablishmentProtocol
    
    init(network: NetworkUploadPhotosEstablishmentProtocol = NetworkUploadPhotosEstablishment()) {
        self.network = network
    }
    
    func uploadImages(establishmentID: String, images: [Data]) async throws {
        try await network.uploadImages(establishmentID: establishmentID, images: images)
    }
    
    
}
