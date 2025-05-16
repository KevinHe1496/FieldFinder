import Foundation

final class GetMeRepository: GetMeRepositoryProtocol {
    
    let network: NetworkGetMeProtocol
    
    init(network: NetworkGetMeProtocol = NetworkGetMe()) {
        self.network = network
    }
    
    func getUser() async throws -> GetMeModel {
        try await network.getUser()
    }
    
    func updateUser(name: String) async throws -> updateUserModel {
        try await network.updateUser(name: name)
    }
    
    func deleteUser() async throws {
        try await network.deleteUser()
    }
}
