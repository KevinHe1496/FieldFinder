//
//  GetNearbyEstablismentsRepository.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation
import CoreLocation

final class GetNearbyEstablismentsRepository: GetNearbyEstablishmentsProtocol {
    
    private var network: NetworkGetNearbyEstablishmentsProtocol
    
    init(network: NetworkGetNearbyEstablishmentsProtocol = NetworkGetNearbyEstablishments()) {
        self.network = network
    }
    
    func getAllEstablishments(coordinate: CLLocationCoordinate2D) async throws -> [Establecimiento] {
        return try await network.getAllEstablishments(coordinate: coordinate)
    }
}
