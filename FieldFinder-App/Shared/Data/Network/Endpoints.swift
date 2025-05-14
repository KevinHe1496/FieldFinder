import Foundation

/// Endpoints of Server Side
enum Endpoints: String {
    case login = "/auth/login"
    case getEstablishments = "/establecimiento/getEstablecimientos"
    case registerUsers = "/auth/register"
    case getMe = "/users/me"
    case registerEstablishment = "/establecimiento/register"
    case uploadImagesEstablishment = "/establecimiento/fotos"
    case getNearbyEstablishments = "/establecimiento/nearby"
    case getEstablishmentById = "/establecimiento"

}
