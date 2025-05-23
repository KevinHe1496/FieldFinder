import Foundation

final class GetMeRepository: GetMeRepositoryProtocol {
    
    let network: NetworkGetMeProtocol
    
    init(network: NetworkGetMeProtocol = UserProfileService()) {
        self.network = network
    }
    
    func getUser() async throws -> UserProfileResponse {
        try await network.fetchUser()
    }
    
    func updateUser(name: String) async throws -> UserProfileRequest {
        try await network.updateUser(name: name)
    }
    
    func deleteUser() async throws {
        try await network.deleteUser()
    }
}
