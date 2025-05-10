import Foundation

protocol GetMeUseCaseProtocol {
    var repo: GetMeRepositoryProtocol { get set }
    func getUser() async throws -> GetMeModel
}

final class GetMeUseCase: GetMeUseCaseProtocol {
    var repo: GetMeRepositoryProtocol
    
    init(repo: GetMeRepositoryProtocol = GetMeRepository()) {
        self.repo = repo
    }
    
    func getUser() async throws -> GetMeModel {
        try await repo.getUser()
    }
}
