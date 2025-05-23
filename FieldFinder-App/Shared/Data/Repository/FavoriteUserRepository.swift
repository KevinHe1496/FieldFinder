//
//  FavoriteUserRepository.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//
import Foundation

final class FavoriteUserRepository: FavoriteUserRepositoryProtocol {

    private let network: UserFavoritesServiceProtocol

    init(network: UserFavoritesServiceProtocol = UserFavoritesService()) {
        self.network = network
    }

    func favoriteUser(establishmentId: String) async throws {
        try await network.addFavorite(with: establishmentId)
    }

    func deleteFavoriteUser(establishmentId: String) async throws {
        try await network.removeFavorite(with: establishmentId)
    }
    
    func getFavoriteUser() async throws -> [FavoriteEstablishment] {
        try await network.fetchFavorites()
    }
}
