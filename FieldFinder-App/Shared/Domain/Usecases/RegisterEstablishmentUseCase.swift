import Foundation

protocol RegisterEstablishmentUseCaseProtocol {
    var repo: EstablishmentServiceRepositoryProtocol { get set }
    func registerEstablishment(_ establishmentModel: EstablishmentRequest) async throws -> String
    func uploadImages(establishmentID: String, images: [Data]) async throws
    func editEstablishment(establishmentID: String, establishmentModel: EstablishmentRequest) async throws
}

final class RegisterEstablishmentUseCase: RegisterEstablishmentUseCaseProtocol {
    var repo: EstablishmentServiceRepositoryProtocol
    
    init(repo: EstablishmentServiceRepositoryProtocol = EstablishmentServiceRepository()) {
        self.repo = repo
    }
    
    func registerEstablishment(_ establishmentModel: EstablishmentRequest) async throws -> String  {
        try await repo.registerEstablishment(establishmentModel)
    }
    
    func uploadImages(establishmentID: String, images: [Data]) async throws {
        try await repo.uploadImages(establishmentID: establishmentID, images: images)
    }
    
    func editEstablishment(establishmentID: String, establishmentModel: EstablishmentRequest) async throws {
        try await repo.editEstablishment(establishmentID: establishmentID, establishmentModel: establishmentModel)
    }
    
    
}
