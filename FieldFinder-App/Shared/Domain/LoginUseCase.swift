//
//  LoginUseCase.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 8/5/25.
//

import Foundation

final class LoginUseCase: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol
    
    @FFPersistenceKeyChain(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    var tokenJWT
    
    init(repo: LoginRepositoryProtocol = LoginRepository()) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async throws -> Bool {
        // Guardamos el token
        let token = try await repo.loginApp(user: user, password: password)
        // Verificamos si el token nos vino vacio o no
        if token != "" {
           // KeyChainFF().savePK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN, value: token)
            tokenJWT = token
            return true // Success
        } else {
           // KeyChainFF().deletePK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
            tokenJWT = ""
            return false // Error
        }
    }
    
    func logout() async throws {
        KeyChainFF().deletePK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        if tokenJWT != "" {
            // Validación de expiración
            return true
        } else {
            return false
        }
    }
    
    
}
