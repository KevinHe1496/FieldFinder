import Foundation

struct GetMeModel: Codable {
    let email: String
    let id: String
    let rol: String
    let name: String
    let establecimiento: [EstablecimientoReponse]
    
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

struct updateUserModel: Codable {
    let name: String
}


// MARK: - Establecimiento
struct EstablecimientoReponse: Codable, Identifiable {
    let longitude: Double
    let info, address: String
    let fotos: [String]
    let parquedero: Bool
    let userName, id, name, zipCode: String
    let city: String
    let canchas: [CanchaResponse]
    let phone: String
    let vestidores, duchas: Bool
    let userRol: String
    let banos, bar: Bool
    let country: String
    let latitude: Double
    
    
    static let sample = EstablecimientoReponse(
        longitude: 1.0,
        info: "Cancha Sintética grande",
        address: "Av. Shirys y Amazonas",
        fotos: ["https://fieldfinder-uploads.s3.us-east-2.amazonaws.com/establecimiento/AB5C5912-B724-45D9-9652-82CC28F060F8-italia.png"],
        parquedero: true,
        userName: "Kevin",
        id: "1",
        name: "Kevin",
        zipCode: "170504",
        city: "Quito",
        canchas: [CanchaResponse(tipo: "Natural", modalidad: "7-7", id: "1", cubierta: true, iluminada: true, precio: 4, fotos: ["https://fieldfinder-uploads.s3.us-east-2.amazonaws.com/establecimiento/AB5C5912-B724-45D9-9652-82CC28F060F8-italia.png"])],
        phone: "0998041792",
        vestidores: true,
        duchas: false,
        userRol: "Dueño",
        banos: true,
        bar: true,
        country: "Ecuador",
        latitude: 1.0
    )
    
    var photoEstablishment: [URL] {
        fotos.compactMap { url in
            URL(string: "\(url)")
        }
    }
    
}


// MARK: - Cancha
struct CanchaResponse: Codable, Identifiable {
    let tipo, modalidad, id: String
    let cubierta, iluminada: Bool
    let precio: Double
    let fotos: [String]
    
    
    static let sample = CanchaResponse(tipo: "Sintética", modalidad: "7-7", id: "1", cubierta: true, iluminada: true, precio: 45, fotos: ["https://fieldfinder-uploads.s3.us-east-2.amazonaws.com/establecimiento/AB5C5912-B724-45D9-9652-82CC28F060F8-italia.png"])
    
    var photoCancha: [URL] {
        fotos.compactMap { url in
            URL(string: "\(url)")
        }
    }
    
}
