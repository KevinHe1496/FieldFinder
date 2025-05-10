import Foundation

protocol RegisterUseCaseProtocol {
    var repo: RegisterRepositoryProtocol { get set }
    func registerUsers(name: String, email: String, password: String, rol: String) async throws -> Bool
}


final class RegisterUseCase: RegisterUseCaseProtocol {
    var repo: RegisterRepositoryProtocol
    
    @FFPersistenceKeyChain(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    var tokenJWT
    
    init(repo: RegisterRepositoryProtocol = RegisterRepository()) {
        self.repo = repo
    }
    
    func registerUsers(name: String, email: String, password: String, rol: String) async throws -> Bool {
        let token = try await repo.registerUsers(name: name, email: email, password: password, rol: rol)
        
        if token != "" {
            tokenJWT = token
            return true
        } else {
            tokenJWT = ""
            return false
        }
    }
    
    
}
