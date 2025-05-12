//
//  GetNearbyEstablishmentsUseCase.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation
import CoreLocation

protocol GetNearbyEstablishmentsUseCaseProtocol {
    var repo: GetNearbyEstablishmentsProtocol { get set }
    
    func getAllEstablishments(coordinate: CLLocationCoordinate2D) async throws -> [Establecimiento]
}

final class GetNearbyEstablishmentsUseCase: GetNearbyEstablishmentsUseCaseProtocol {
    var repo: GetNearbyEstablishmentsProtocol
    
    init(repo: GetNearbyEstablishmentsProtocol = GetNearbyEstablismentsRepository()) {
        self.repo = repo
    }
    
    func getAllEstablishments(coordinate: CLLocationCoordinate2D) async throws -> [Establecimiento] {
        return try await repo.getAllEstablishments(coordinate: coordinate)
    }
}
