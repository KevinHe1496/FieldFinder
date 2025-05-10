import Foundation

protocol RegisterRepositoryProtocol {
    func registerUsers(name: String, email: String, password: String, rol: String) async throws -> String
}
