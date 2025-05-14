import Foundation

@MainActor
@Observable
final class OwnerViewModel {
    
    var establishments = GetMeModel(email: "", id: "", rol: "", name: "", establecimiento: [])
    @ObservationIgnored
    private var useCase: GetMeUseCaseProtocol
    
    init(useCase: GetMeUseCaseProtocol = GetMeUseCase()) {
        self.useCase = useCase
        Task {
            await getEstablishments()
        }
    }
    
    
    func getEstablishments() async {
        do {
            let data = try await useCase.getUser()
            establishments = data
        } catch {
            print("Error en el viewModel decodificando datos")
        }
        
    }
}
