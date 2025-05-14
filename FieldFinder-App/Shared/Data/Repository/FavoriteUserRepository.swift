//
//  FavoriteUserRepository.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//
import Foundation

final class FavoriteUserRepository: FavoriteUserRepositoryProtocol {

    private let network: NetworkFavoriteUserProtocol

    init(network: NetworkFavoriteUserProtocol = NetworkFavoriteUser()) {
        self.network = network
    }

    func favoriteUser(establishmentId: String) async throws {
        try await network.favoriteUser(with: establishmentId)
    }

    func deleteFavoriteUser(establishmentId: String) async throws {
        try await network.deleteFavoriteUser(with: establishmentId)
    }
    
    func getFavoriteUser() async throws -> [FavoriteEstablishment] {
        try await network.getFavoriteUser()
    }
}
