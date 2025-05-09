import Foundation

final class LoginRepository: LoginRepositoryProtocol {
     
    var network: NetworkLoginProtocol
    
    init(network: NetworkLoginProtocol = NetworkLogin()) {
        self.network = network
    }
    
    func loginApp(user: String, password: String) async throws -> String {
        try await network.loginApp(user: user, password: password)
    }
    
    
}


// MOCK

final class LoginRepositoryMock: LoginRepositoryProtocol {
     
    var network: NetworkLoginProtocol
    
    init(network: NetworkLoginProtocol = NetworkLoginMock()) {
        self.network = network
    }
    
    func loginApp(user: String, password: String) async throws -> String {
        try await network.loginApp(user: user, password: password)
    }
    
    
}
