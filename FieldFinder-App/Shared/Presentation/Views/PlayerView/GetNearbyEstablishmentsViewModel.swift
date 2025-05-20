//
//  PlayerViewModel.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation
import CoreLocation
import _MapKit_SwiftUI
import SwiftUI

// ViewModel que gestiona la lógica para mostrar establecimientos cercanos en un mapa.
final class GetNearbyEstablishmentsViewModel: ObservableObject {
    
    var locationService = LocationService() // Servicio para obtener la ubicación del usuario.
    
    // Valor que controla cuánto se ve (zoom del mapa).
    @Published var lastLatitudeDelta: Double = 0.05
    
    // Lista de establecimientos cercanos obtenidos desde el backend.
    @Published var nearbyEstablishments = [Establecimiento]()
    
    // Lista de establecimientos favoritos del usuario.
    @Published var favoritesData = [FavoriteEstablishment]()
    
    // Establecimiento seleccionado por el usuario (para ver detalles).
    @Published var selectedEstablishment: Establecimiento?
    
    // Controla la posición de la cámara del mapa (zoom y centro).
    @Published var cameraPosition: MapCameraPosition = .automatic
    
    // Texto del buscador de establecimientos.
    @Published var establishmentSearch = ""
    
    // Devuelve los establecimientos filtrados por nombre según lo que escribe el usuario.
    var filterEstablishments: [Establecimiento] {
        if establishmentSearch.isEmpty {
            nearbyEstablishments
        } else {
            nearbyEstablishments.filter { establishment in
                establishment.name.localizedStandardContains(establishmentSearch)
            }
        }
    }
    
    // Casos de uso para obtener establecimientos (se comunica con la capa de red).
    @ObservationIgnored
    private var useCase: GetNearbyEstablishmentsUseCaseProtocol
    
    // Casos de uso para favoritos del usuario.
    @ObservationIgnored
    private let favoriteUseCase: FavoriteUserUseCaseProtocol
    
    // Inicializa el ViewModel con las dependencias necesarias.
    init(useCase: GetNearbyEstablishmentsUseCaseProtocol = GetNearbyEstablishmentsUseCase(), favoriteUseCase: FavoriteUserUseCaseProtocol = FavoriteUserUseCase()) {
        self.useCase = useCase
        self.favoriteUseCase = favoriteUseCase
    }
    
    // Obtiene la lista de establecimientos cercanos desde la API, según una ubicación.
    @MainActor
    private func fetchEstablishments(near coordinate: CLLocationCoordinate2D) async throws {
        let result = try await useCase.getAllEstablishments(coordinate: coordinate)
        nearbyEstablishments = result
    }
    
    // Carga los datos iniciales: obtiene ubicación, establecimientos y centra el mapa.
    @MainActor
    func loadData() async throws {
        let coordinates = try await locationService.requestLocation()
        try await fetchEstablishments(near: coordinates)
        updateCamera(to: coordinates) // Centra el mapa en la ubicación del usuario.
    }
    
    // Marca o desmarca un establecimiento como favorito.
    @MainActor
    func toggleFavorite(establishmentId: String, isFavorite: Bool) async throws {
        if isFavorite {
            try await favoriteUseCase.favoriteUser(establishmentId: establishmentId)
        } else {
            try await favoriteUseCase.deleteFavoriteUser(establishmentId: establishmentId)
        }
        try await self.getFavoritesUser() // Actualiza la lista de favoritos.
    }
    
    // Carga los establecimientos favoritos del usuario.
    @MainActor
    func getFavoritesUser() async throws {
        let data = try await favoriteUseCase.getFavoriteUser()
        self.favoritesData = data
    }
    
    /// Actualiza la posición de la cámara en el mapa.
    /// Este método permite centrar el mapa sobre unas coordenadas específicas (como la ubicación del usuario).
    @MainActor
    private func updateCamera(to coordinate: CLLocationCoordinate2D) {
        withAnimation {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02) // Cambia este valor para alejar/acercar el mapa.
                )
            )
        }
    }

    /// Guarda el establecimiento que el usuario selecciona para mostrar sus detalles.
    @MainActor
    func selectEstablishment(_ establishment: Establecimiento) {
        selectedEstablishment = establishment
    }
    
    /// Centra la cámara del mapa en la ubicación actual del usuario.
    @MainActor
    func centerOnUserLocation() async {
        do {
            let coordinate = try await locationService.requestLocation()
            updateCamera(to: coordinate)
        } catch {
            print("Error centering on user location: \(error)")
        }
    }
    
    func isFavorite(establishmentId: String) -> Bool {
        favoritesData.contains { favorite in
            favorite.id == establishmentId
        }
    }



}
