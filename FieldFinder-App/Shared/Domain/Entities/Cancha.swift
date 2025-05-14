//
//  Cancha.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//
import Foundation

struct Cancha: Codable, Identifiable {
    let id: String
    let tipo: String
    let modalidad: String
    let precio: Int
    let cubierta: Bool
    let iluminada: Bool
    let fotos: [String]
    
    var photoCanchas: [URL] {
        fotos.compactMap { url in
            URL(string: "\(url)")
        }
    }
    
    static let sample = Cancha(
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
