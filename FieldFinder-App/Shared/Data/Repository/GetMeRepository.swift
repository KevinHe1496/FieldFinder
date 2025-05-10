import Foundation

final class GetMeRepository: GetMeRepositoryProtocol {
    
    let network: NetworkGetMeProtocol
    
    init(network: NetworkGetMeProtocol = NetworkGetMe()) {
        self.network = network
    }
    
    func getUser() async throws -> GetMeModel {
        try await network.getUser()
    }
    
    
}
