import Foundation
import Combine
import StoreKit

@Observable
final class AppState {
    // Published
    var status = StatusModel.login
    var tokenJWT: String = ""
    var userRole: UserRole?
    var messageAlert: String = ""
    var showAlert: Bool = false
    var isLoading: Bool = false
    // No Published
    @ObservationIgnored
    var isLogged: Bool = false
    var hasAskedReviewForRegisterField = false
    
    private var storeTask: Task<Void, Never>?
    
    /// The StoreKit products we've loaded for the store.
    var products = [Product]()
    /// The UserDefaults suite where we're saving user data.
    let defaults: UserDefaults
    
    @ObservationIgnored
    private var loginUseCase: UserAuthServiceUseCaseProtocol
    
    init(loginUseCase: UserAuthServiceUseCaseProtocol = UserAuthServiceUseCase(), defaults: UserDefaults = .standard) {
        self.loginUseCase = loginUseCase
        self.defaults = defaults
        
        Task {
            await validateToken()
        }
        
        storeTask = Task {
            await monitorTransactions()
        }
    }
    
    @MainActor
    func login(email: String, password: String) async throws {
        
        isLoading = true
        guard !email.isEmpty || !password.isEmpty else {
            messageAlert = "Los campos son requeridos."
            showAlert = true
            return
        }
        
        
        
        do {
            
            let loginApp = try await loginUseCase.login(email: email, password: password)
            
            if loginApp == true {
                // Login Success
                self.status = .loading
                
                let user = try await UserProfileServiceUseCase().fetchUser()
                self.userRole = user.userRole
                
                
                self.status = .loaded
                self.isLoading = false
            } else {
                // Login Error
                showAlert = true
                messageAlert = "El email o la contraseña son inválidos."
                isLoading = false
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
                let user = try await UserProfileServiceUseCase().fetchUser()
                self.userRole = user.userRole
                self.status = .loaded
                
            } else {
                self.status = .login
                NSLog("Login Error")
            }
        }
    }
    
    /// Detectar si está suscrito o en prueba gratuita
    @MainActor
    func checkSubscriptionStatus() async {
        for await result in Transaction.currentEntitlements {
            print("🔁 Verificando estado de suscripción...")
            if case .verified(let transaction) = result,
               transaction.productID == Self.unlockPremiumProductID {
                print("📦 Producto: \(transaction.productID)")
                print("🔒 Activa: \(transaction.revocationDate == nil)")
                print("🧪 Free Trial: \(transaction.offer?.type == .introductory)")
                fullVersionUnlocked = transaction.revocationDate == nil
                isOnFreeTrial = transaction.offer?.type == .introductory
                return
            }
        }
        
        fullVersionUnlocked = false
        isOnFreeTrial = false
    }
    
    // Función recomendada por Apple (fuera del body)
    @MainActor
    func requestReviewIfAppropriate() {
        guard let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        
        AppStore.requestReview(in: scene)
    }
}
