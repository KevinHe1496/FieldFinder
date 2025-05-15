import Foundation

protocol GetMeUseCaseProtocol {
    var repo: GetMeRepositoryProtocol { get set }
    func getUser() async throws -> GetMeModel
    func updateUser(name: String) async throws -> updateUserModel
    func deleteUser() async throws
}

final class GetMeUseCase: GetMeUseCaseProtocol {
    var repo: GetMeRepositoryProtocol
    
    init(repo: GetMeRepositoryProtocol = GetMeRepository()) {
        self.repo = repo
    }
    
    func getUser() async throws -> GetMeModel {
        try await repo.getUser()
    }
    
    func updateUser(name: String) async throws -> updateUserModel {
        try await repo.updateUser(name: name)
    }
    
    func deleteUser() async throws {
        try await repo.deleteUser()
    }
}
