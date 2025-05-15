import Foundation

protocol UploadPhotosEstablishmentRepositoryProtocol {
    func uploadImages(establishmentID: String, images: [Data]) async throws
}
