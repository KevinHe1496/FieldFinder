//
//  EstablishmentDetailViewModel.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation
import UIKit

@Observable
final class EstablishmentDetailViewModel {
    var status: ViewState<Establecimiento> = .idle
    var showOpenInMapsAlert = false
    var mapsURL: URL?
    
    @ObservationIgnored
    private var useCase: GetEstablishmentDetailUseCaseProtocol
    
    @ObservationIgnored
    private var favoriteUseCase: FavoriteUserUseCaseProtocol
    
    init(useCase: GetEstablishmentDetailUseCaseProtocol = GetEstablishmentDetailUseCase(), favoriteUseCase: FavoriteUserUseCaseProtocol = FavoriteUserUseCase()) {
        self.useCase = useCase
        self.favoriteUseCase = favoriteUseCase
    }
    
    @MainActor
    func getEstablishmentDetail(establishmentId: String) async throws {
        status = .loading
        do {
            let establecimiento = try await useCase.getEstablishmentDetail(with: establishmentId)
            status = .success(establecimiento)
        } catch {
            status = .error("No se pudo cargar el establecimiento")
        }
    }
    
    @MainActor
    func addToFavorites(establishmentId: String) async throws {
        try await favoriteUseCase.favoriteUser(establishmentId: establishmentId)
    }
    
    @MainActor
    func removeFromFavorites(establishmentId: String) async throws {
        try await favoriteUseCase.deleteFavoriteUser(establishmentId: establishmentId)
    }
    
    @MainActor
    func prepareMapsURL(for establishment: Establecimiento) {
        let coordinate = establishment.coordinate

        guard coordinate.latitude != 0.0, coordinate.longitude != 0.0 else {
            return // Coordenadas vacías, no hacemos nada
        }

        let placeName = establishment.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Ubicación"

        if let url = URL(string: "maps://?q=\(placeName)&ll=\(coordinate.latitude),\(coordinate.longitude)") {
            mapsURL = url
            showOpenInMapsAlert = true
        }
    }

    
    @MainActor
    func openMapsURL() {
        if let url = mapsURL {
            UIApplication.shared.open(url)
        }
    }

}
