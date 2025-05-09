//
//  LoginUseCaseProtocol.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 8/5/25.
//

import Foundation

protocol LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol { get set }
    func loginApp(user: String, password: String) async throws -> Bool
    func logout() async throws -> Void
    func validateToken() async -> Bool
}
