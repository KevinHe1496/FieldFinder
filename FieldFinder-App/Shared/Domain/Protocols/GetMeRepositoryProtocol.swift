import Foundation

protocol GetMeRepositoryProtocol {
    func getUser() async throws -> GetMeModel
}
