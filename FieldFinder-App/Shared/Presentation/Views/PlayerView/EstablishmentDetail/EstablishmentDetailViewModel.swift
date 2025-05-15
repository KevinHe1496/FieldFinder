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
    
    var showOpenInMapsAlert = false
    var mapsURL: URL?
    
    var establishmentData = Establecimiento(
        id: "",
        name: "",
        info: "",
        address: "",
        city: "",
        isFavorite: false,
        zipCode: "",
        country: "",
        phone: "",
        userName: "",
        userRol: "",
        parquedero: false,
        vestidores: false,
        banos: false,
        duchas: false,
        bar: false,
        fotos: [""],
        latitude: 0.0,
        longitude: 0.0,
        canchas: [Cancha(
            id: "",
            tipo: "",
            modalidad: "",
            precio: 0,
            cubierta: false,
            iluminada: false,
            fotos: [""]
        )]
    )
    
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
        let data = try await useCase.getEstablishmentDetail(with: establishmentId)
        establishmentData = data
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
