import Foundation

protocol RegisterEstablismentRepositoryProtocol {
    func registerEstablishment(_ establishmentModel: EstablishmentModel) async throws -> String
    func uploadImages(establishmentID: String, images: [Data]) async throws
    func editEstablishment(establishmentID: String, establishmentModel: EstablishmentModel) async throws
}
