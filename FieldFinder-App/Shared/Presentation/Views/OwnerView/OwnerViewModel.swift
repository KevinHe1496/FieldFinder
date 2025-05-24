import Foundation

@MainActor
@Observable
final class OwnerViewModel {
    
    var establishments = UserProfileResponse(email: "", id: "", rol: "", name: "", establecimiento: [])
    @ObservationIgnored
    private var useCase: UserProfileServiceUseCaseProtocol

    
    init(useCase: UserProfileServiceUseCaseProtocol = UserProfileServiceUseCase()) {
        self.useCase = useCase
        Task {
            await getEstablishments()
        }
    }
    
    
    func getEstablishments() async {
        do {
            let data = try await useCase.fetchUser()
            establishments = data
        } catch {
            print("Error en el viewModel decodificando datos")
        }
        
    }
}
