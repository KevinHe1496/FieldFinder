import Foundation
// Register and Update
struct CanchaRequest: Codable {
    let tipo: String
    let modalidad: String
    let precio: Double
    let iluminada: Bool
    let cubierta: Bool
 
}

// Response ID
struct IDResponse: Codable {
    let id: String
}

// Get by ID
struct CanchaResponse: Codable, Identifiable {
    let id: String
    let tipo: String
    let modalidad: String
    let precio: Double
    let cubierta: Bool
    let iluminada: Bool
    let fotos: [String]
    
    var photoCanchas: [URL] {
        fotos.compactMap { url in
            URL(string: "\(url)")
        }
    }
    
    static let sample = CanchaResponse(
        id: "cancha001",
        tipo: "Fútbol 7",
        modalidad: "Partido completo",
        precio: 30,
        cubierta: true,
        iluminada: true,
        fotos: [
            "https://ejemplo.com/fotos/cancha001-1.jpg",
            "https://ejemplo.com/fotos/cancha001-2.jpg"
        ]
    )
}
