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
}
