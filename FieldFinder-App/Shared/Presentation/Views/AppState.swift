import Foundation
import Combine

@Observable
final class AppState {
    // Published
    var status = StatusModel.none
    var tokenJWT: String = ""
    var userRole: UserRole?
    // No Published
    @ObservationIgnored
    var isLogged: Bool = false
    
    private var loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
        // Temporal
        KeyChainFF().deletePK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        Task {
            await validateToken()
        }
        
        
    }
    
    @MainActor
    func loginApp(user: String, password: String)  {
        
        self.status = .loading
        
        Task {
            
            let loginApp = try await loginUseCase.loginApp(user: user, password: password)
            
            if loginApp == true {
                // Login Success
                let user = try await GetMeUseCase().getUser()
                self.userRole = user.userRole
                
                self.status = .loaded
            } else {
                // Login Error
                self.status = .error(error: "Error with the user or password")
            }
        }
    }
    
    // Close session
    @MainActor
    func closeSessionUser() {
        Task {
            try await loginUseCase.logout()
            self.status = .none
        }
        
    }
    
    @MainActor
    func validateToken() {
        Task {
            if (await loginUseCase.validateToken() == true) {
                let user = try await GetMeUseCase().getUser()
                self.userRole = user.userRole
                self.status = .loaded
                NSLog("Login OK")
            } else {
                self.status = .none
                NSLog("Login Error")
            }
        }
    }
    
}


