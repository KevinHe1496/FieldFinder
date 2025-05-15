import Foundation

/// Status app
enum StatusModel {
    case none, loading, loaded, register, error(error: String), ownerView, uploadPhotoEstablishment
}
