//
//  GetNearbyEstablishmentsProtocol.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation
import CoreLocation

protocol GetNearbyEstablishmentsProtocol {
    func getAllEstablishments(coordinate: CLLocationCoordinate2D) async throws -> [EstablishmentResponse]
}
