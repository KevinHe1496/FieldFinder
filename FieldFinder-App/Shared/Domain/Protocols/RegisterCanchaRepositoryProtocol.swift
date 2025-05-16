import Foundation

protocol RegisterCanchaRepositoryProtocol {
    func registerCancha(_ canchaModel: RegisterCanchaModel) async throws -> String
    func uploadImagesCancha(canchaID: String, images: [Data]) async throws
}
