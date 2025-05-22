import Foundation

protocol RegisterCanchaUseCaseProtocol {
    var repo: RegisterCanchaRepositoryProtocol { get set }
    func registerCancha(_ canchaModel: CanchaRequest) async throws -> String
    func uploadPhotosCancha(canchaID: String, images: [Data]) async throws
    func editCancha(canchaID: String, canchaModel: CanchaRequest) async throws -> CanchaRequest
    func deleteCancha(canchaID: String) async throws
}

final class RegisterCanchaUseCase: RegisterCanchaUseCaseProtocol {
   
    
    var repo: RegisterCanchaRepositoryProtocol
    
    init(repo: RegisterCanchaRepositoryProtocol = RegisterCanchaRepository()) {
        self.repo = repo
    }
    
    func registerCancha(_ canchaModel: CanchaRequest) async throws -> String {
        try await repo.registerCancha(canchaModel)
    }
    
    
    func uploadPhotosCancha(canchaID: String, images: [Data]) async throws {
        try await repo.uploadImagesCancha(canchaID: canchaID, images: images)
    }
    
    func editCancha(canchaID: String, canchaModel: CanchaRequest) async throws -> CanchaRequest {
        try await repo.editCancha(canchaID: canchaID, canchaModel: canchaModel)
    }
    
    func deleteCancha(canchaID: String) async throws {
        try await repo.deleteCancha(canchaID: canchaID)
    }
    
}
