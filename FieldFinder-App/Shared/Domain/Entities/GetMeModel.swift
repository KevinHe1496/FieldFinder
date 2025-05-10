import Foundation

struct GetMeModel: Codable {
    let email: String
    let id: String
    let rol: String
    let name: String
    
    var userRole: UserRole? {
        switch rol.lowercased() {
        case "jugador":
            return .jugador
        case "dueno":
            return .dueno
        default:
            return nil
        }
    }
}
