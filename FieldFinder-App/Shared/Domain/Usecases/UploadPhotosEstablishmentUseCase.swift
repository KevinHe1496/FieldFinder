import Foundation

protocol UploadPhotosEstablishmentUseCaseProtocol {
    var repo: UploadPhotosEstablishmentRepositoryProtocol { get set }
    func uploadImages(establishmentID: String, images: [Data]) async throws
}

final class UploadPhotosEstablishmentUseCase: UploadPhotosEstablishmentUseCaseProtocol {
    var repo: UploadPhotosEstablishmentRepositoryProtocol
    
    init(repo: UploadPhotosEstablishmentRepositoryProtocol = UploadPhotosEstablishmentRepository()) {
        self.repo = repo
    }
    
    func uploadImages(establishmentID: String, images: [Data]) async throws {
        try await repo.uploadImages(establishmentID: establishmentID, images: images)
    }
    
    
}
