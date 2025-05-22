import Foundation


// MARK: -- StatusModel

enum StatusModel: Equatable {
    case login, loading, loaded, register, error(error: String), ownerView, registerCancha, home, registerUser
}


// MARK: -- ViewState

enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case error(String)
}


extension ViewState {
    var data: T? {
        if case let .success(value) = self {
            return value
        }
        return nil
    }
}


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



enum Field: String, CaseIterable, Identifiable {
    case cesped = "cesped"
    case sintetico = "sintetico"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .sintetico: return "Sintético"
        case .cesped: return "Césped"
        }
    }
}

enum Capacidad: String, CaseIterable, Identifiable {
    case cinco = "5-5"
    case siete = "7-7"
    case nueve = "9-9"
    case once = "11-11"
    
    var id: String { self.rawValue }
}
