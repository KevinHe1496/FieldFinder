//
//  FavoriteUserUseCase.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//
import Foundation

protocol FavoriteUserUseCaseProtocol {
    func favoriteUser(establishmentId: String) async throws
    func deleteFavoriteUser(establishmentId: String) async throws
    func getFavoriteUser() async throws -> [FavoriteEstablishment]
}


final class FavoriteUserUseCase: FavoriteUserUseCaseProtocol {
    private let repository: FavoriteUserRepositoryProtocol

    init(repository: FavoriteUserRepositoryProtocol = FavoriteUserRepository()) {
        self.repository = repository
    }

    func favoriteUser(establishmentId: String) async throws {
        try await repository.favoriteUser(establishmentId: establishmentId)
    }

    func deleteFavoriteUser(establishmentId: String) async throws {
        try await repository.deleteFavoriteUser(establishmentId: establishmentId)
    }
    
    func getFavoriteUser() async throws -> [FavoriteEstablishment] {
        try await repository.getFavoriteUser()
    }
}
