import Foundation

final class RegisterRepository: RegisterRepositoryProtocol {
    
    var network: NetworkRegisterProtocol
    
    init(network: NetworkRegisterProtocol = NetworkRegister()) {
        self.network = network
    }
    
    func registerUsers(name: String, email: String, password: String, rol: String) async throws -> String {
        try await network.registerUsers(name: name, email: email, password: password, rol: rol)
    }
}
