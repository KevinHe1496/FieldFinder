import Foundation

protocol RegisterCanchaRepositoryProtocol {
    func registerCancha(_ canchaModel: CanchaRequest) async throws -> String
    func uploadImagesCancha(canchaID: String, images: [Data]) async throws
    func editCancha(canchaID: String, canchaModel: CanchaRequest) async throws -> CanchaRequest
    func deleteCancha(canchaID: String) async throws
}
