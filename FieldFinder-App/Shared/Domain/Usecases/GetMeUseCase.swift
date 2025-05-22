import Foundation

protocol GetMeUseCaseProtocol {
    var repo: GetMeRepositoryProtocol { get set }
    func getUser() async throws -> UserProfileResponse
    func updateUser(name: String) async throws -> UserProfileRequest
    func deleteUser() async throws
}

final class GetMeUseCase: GetMeUseCaseProtocol {
    var repo: GetMeRepositoryProtocol
    
    init(repo: GetMeRepositoryProtocol = GetMeRepository()) {
        self.repo = repo
    }
    
    func getUser() async throws -> UserProfileResponse {
        try await repo.getUser()
    }
    
    func updateUser(name: String) async throws -> UserProfileRequest {
        try await repo.updateUser(name: name)
    }
    
    func deleteUser() async throws {
        try await repo.deleteUser()
    }
}
