import Foundation

protocol RegisterEstablishmentUseCaseProtocol {
    var repo: RegisterEstablismentRepositoryProtocol { get set }
    func registerEstablishment(_ establishmentModel: EstablishmentModel) async throws
}

final class RegisterEstablishmentUseCase: RegisterEstablishmentUseCaseProtocol {
    var repo: RegisterEstablismentRepositoryProtocol
    
    init(repo: RegisterEstablismentRepositoryProtocol = RegisterEstablishmentRepository()) {
        self.repo = repo
    }
    
    func registerEstablishment(_ establishmentModel: EstablishmentModel) async throws  {
        try await repo.registerEstablishment(establishmentModel)
    }
    
    
}
