import Foundation

protocol EstablishmentServiceRepositoryProtocol {
    func createEstablishment(_ establishmentModel: EstablishmentRequest) async throws -> String
    func uploadEstablishmentImages(establishmentID: String, images: [Data]) async throws
    func updateEstablishment(establishmentID: String, establishmentModel: EstablishmentRequest) async throws
    func fetchEstablishment(with establishmentId: String) async throws -> EstablishmentResponse
}
