import Foundation

protocol GetMeRepositoryProtocol {
    func getUser() async throws -> GetMeModel
    func updateUser(name: String) async throws -> updateUserModel
    func deleteUser() async throws
}
