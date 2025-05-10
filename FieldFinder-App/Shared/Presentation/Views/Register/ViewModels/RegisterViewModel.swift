import Foundation

@Observable
final class RegisterViewModel {
    // MARK: -- Properties
    private var appState: AppState
    var isLoading: Bool = false
    var isRegistered: Bool = false
    var errorMessage: String?
    var tokenJWT: String = ""
    
    @ObservationIgnored
    private let useCase: RegisterUseCaseProtocol
    
    // MARK: - Initialization
    init(appState: AppState, useCase: RegisterUseCaseProtocol = RegisterUseCase()) {
        self.appState = appState
        self.useCase = useCase
    }
    
    @MainActor
    func userRegister(name: String, email: String, password: String, rol: String) async -> String? {
        if let validationError = validateFields(name: name, email: email, password: password) {
            isLoading = false
            return validationError
        }
        
        isLoading = true
        errorMessage = nil
        appState.status = .loading
        
        do {
            let result = try await useCase.registerUsers(name: name, email: email, password: password, rol: rol)
            
            if result {
                appState.status = .none
                isLoading = false
                return nil
            } else {
                appState.status = .error(error: "Incorrect username or password")
                isLoading = false
                return "Incorrect username or password"
            }
        } catch {
            appState.status = .error(error: "Something went wrong")
            isLoading = false
            return "Something went wrong"
        }
    }
    
    
    // MARK: - Validation

    /// Checks that all fields are filled and email/password are valid.
    func validateFields(name: String, email: String, password: String) -> String? {
        if name.isEmpty || email.isEmpty || password.isEmpty {
            return "All fields are required."
        }
        if !email.contains("@") || !email.contains(".") {
            return "Invalid email or password."
        }
        if password.count < 6 {
            return "Invalid email or password."
        }
        return nil
    }
    
}
