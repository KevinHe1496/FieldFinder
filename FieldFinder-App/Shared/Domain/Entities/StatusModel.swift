import Foundation

/// Status app
enum StatusModel: Equatable {
    case none, loading, loaded, register, error(error: String), ownerView, registerCancha
}


extension StatusModel {
    static func == (lhs: StatusModel, rhs: StatusModel) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none),
            (.ownerView, .ownerView),
            (.register, .register),
            (.registerCancha, .registerCancha),
            (.loading, .loading),
            (.loaded, .loaded):
            return true
        case (.error, .error):
            return true // O puedes comparar los errores si te interesa
        default:
            return false
        }
    }
}
