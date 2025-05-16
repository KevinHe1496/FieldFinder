import Foundation

protocol RegisterCanchaRepositoryProtocol {
    func registerCancha(_ canchaModel: RegisterCanchaModel) async throws -> String
    func uploadImagesCancha(canchaID: String, images: [Data]) async throws
    func editCancha(canchaID: String, canchaModel: RegisterCanchaModel) async throws -> RegisterCanchaModel
    func deleteCancha(canchaID: String) async throws
}
