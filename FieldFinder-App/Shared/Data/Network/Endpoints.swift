import Foundation

/// Endpoints of Server Side
enum Endpoints: String {
    case login = "/auth/login"
    case registerEstablishmment = "/establecimiento/getEstablecimientos"
    case registerUsers = "/auth/register"
    case getMe = "/users/me"
}
