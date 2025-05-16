import Foundation

protocol RegisterEstablishmentUseCaseProtocol {
    var repo: RegisterEstablismentRepositoryProtocol { get set }
    func registerEstablishment(_ establishmentModel: EstablishmentModel) async throws -> String
    func uploadImages(establishmentID: String, images: [Data]) async throws
    func editEstablishment(establishmentID: String, establishmentModel: EstablishmentModel) async throws
}

final class RegisterEstablishmentUseCase: RegisterEstablishmentUseCaseProtocol {
    var repo: RegisterEstablismentRepositoryProtocol
    
    init(repo: RegisterEstablismentRepositoryProtocol = RegisterEstablishmentRepository()) {
        self.repo = repo
    }
    
    func registerEstablishment(_ establishmentModel: EstablishmentModel) async throws -> String  {
        try await repo.registerEstablishment(establishmentModel)
    }
    
    func uploadImages(establishmentID: String, images: [Data]) async throws {
        try await repo.uploadImages(establishmentID: establishmentID, images: images)
    }
    
    func editEstablishment(establishmentID: String, establishmentModel: EstablishmentModel) async throws {
        try await repo.editEstablishment(establishmentID: establishmentID, establishmentModel: establishmentModel)
    }
    
    
}
