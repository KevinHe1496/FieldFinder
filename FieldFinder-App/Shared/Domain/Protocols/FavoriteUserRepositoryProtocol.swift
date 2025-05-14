//
//  FavoriteUserRepositoryProtocol.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//
import Foundation

protocol FavoriteUserRepositoryProtocol {
    func favoriteUser(establishmentId: String) async throws
    func deleteFavoriteUser(establishmentId: String) async throws
    func getFavoriteUser() async throws -> [FavoriteEstablishment]
}
