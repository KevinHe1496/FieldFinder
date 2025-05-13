//
//  GetFieldDetailUseCase.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import Foundation

protocol GetFieldDetailUseCaseProtocol {
    var repo: GetFieldDetailRepositoryProtocol { get set }
    func getFieldDetail(with fieldId: String) async throws -> Cancha
}

final class GetFieldDetailUseCase: GetFieldDetailUseCaseProtocol {
    var repo: GetFieldDetailRepositoryProtocol
    
    init(repo: GetFieldDetailRepositoryProtocol = GetFieldDetailRepository()) {
        self.repo = repo
    }
    
    func getFieldDetail(with fieldId: String) async throws -> Cancha {
        return try await repo.getFieldDetail(with: fieldId)
    }
}
