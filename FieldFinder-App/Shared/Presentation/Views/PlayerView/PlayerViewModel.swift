//
//  PlayerViewModel.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation
import CoreLocation

@Observable
final class PlayerViewModel {
    
    var locationService = LocationService()
    var nearbyEstablishments = [Establecimiento]()
    
    @ObservationIgnored
    private var useCase: GetNearbyEstablishmentsUseCaseProtocol
    
    init(useCase: GetNearbyEstablishmentsUseCaseProtocol = GetNearbyEstablishmentsUseCase()) {
        self.useCase = useCase
    }
    
    @MainActor
    private func fetchEstablishments(near coordinate: CLLocationCoordinate2D) async throws {
        let result = try await useCase.getAllEstablishments(coordinate: coordinate)
        nearbyEstablishments = result
    }
    
    @MainActor
    func loadData() async throws {
        do {
            let coordinates = try await locationService.requestLocation()
            try await fetchEstablishments(near: coordinates)
        } catch {
            print("Error loading Data: \(error.localizedDescription)")
            throw FFError.noLocationFound
        }
    }
}
