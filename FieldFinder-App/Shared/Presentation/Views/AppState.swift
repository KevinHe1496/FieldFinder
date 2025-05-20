import Foundation
import Combine

@Observable
final class AppState {
    // Published
    var status = StatusModel.login
    var tokenJWT: String = ""
    var userRole: UserRole?
    var messageAlert: String = ""
    var showAlert: Bool = false
    // No Published
    @ObservationIgnored
    var isLogged: Bool = false
    
    private var loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
        // Temporal
//        KeyChainFF().deletePK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        Task {
            await validateToken()
        }
        
        
    }
    
    @MainActor
    func loginApp(user: String, password: String) async throws {
        
        
        guard !user.isEmpty || !password.isEmpty else {
            messageAlert = "Los campos son requeridos."
            showAlert = true
            return
        }
        
       
        
        do {
            
            let loginApp = try await loginUseCase.loginApp(user: user, password: password)
            
            if loginApp == true {
                // Login Success
                self.status = .loading
                
                let user = try await GetMeUseCase().getUser()
                self.userRole = user.userRole
                
                
                self.status = .loaded
            } else {
                // Login Error
                showAlert = true
                messageAlert = "El email o la contraseña son inválidos."
                return
            }
        } catch {
            print("Error en el backend o endpoint esta llamada es de AppState")
        }
        showAlert = false
    }
    
    // Close session
    @MainActor
    func closeSessionUser() {
        Task {
            try await loginUseCase.logout()
            self.status = .login
        }
        
    }
    
    @MainActor
    func validateToken() async {
        Task {
            if (await loginUseCase.validateToken() == true) {
                let user = try await GetMeUseCase().getUser()
                self.userRole = user.userRole
                self.status = .loaded
                
            } else {
                self.status = .login
                NSLog("Login Error")
            }
        }
    }
    
}


