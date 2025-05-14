import Foundation

/// Endpoints of Server Side
enum Endpoints: String {
    case login = "/auth/login"
    case registerEstablishmment = "/establecimiento/getEstablecimientos"
    case registerUsers = "/auth/register"
    case getMe = "/users/me"
    case getNearbyEstablishments = "/establecimiento/nearby"
    case getEstablishmentById = "/establecimiento"
    case getFieldById = "/cancha"
    case favoriteUser = "/users/favoritos"
}
