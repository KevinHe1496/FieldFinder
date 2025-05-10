import Foundation

// 1. Enum con los roles
enum UserRole: String, CaseIterable, Identifiable {
    case jugador = "Jugador"
    case dueno = "Dueno"
    
    
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .jugador:
            return "Jugador"
        case .dueno:
            return "Dueño"
        }
    }
}
