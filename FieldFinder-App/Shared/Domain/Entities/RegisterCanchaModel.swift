import Foundation

struct RegisterCanchaModel: Codable {
    let tipo: String
    let modalidad: String
    let precio: Double
    let iluminada: Bool
    let cubierta: Bool
    
    
}


struct IDResponse: Codable {
    let id: String
}
