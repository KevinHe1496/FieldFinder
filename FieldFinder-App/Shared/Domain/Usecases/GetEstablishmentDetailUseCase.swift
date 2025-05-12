//
//  GetEstablishmentDetailUseCase.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation

protocol GetEstablishmentDetailUseCaseProtocol {
    var repo: GetEstablishmentDetailProtocol { get set }
    func getEstablishmentDetail(with establishmentId: String) async throws -> Establecimiento
}

final class GetEstablishmentDetailUseCase:GetEstablishmentDetailUseCaseProtocol {
    var repo: GetEstablishmentDetailProtocol
    
    init(repo: GetEstablishmentDetailProtocol = GetEstablishmentDetailRepository()) {
        self.repo = repo
    }
    
    func getEstablishmentDetail(with establishmentId: String) async throws -> Establecimiento {
        return try await repo.getEstablishmentDetail(with: establishmentId)
    }
}
