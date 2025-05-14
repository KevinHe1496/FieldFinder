//
//  Establecimiento.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 10/5/25.
//

import Foundation

struct EstablishmentModel: Codable {
    let name: String
    let info: String
    let address: String
    let country: String
    let city: String
    let zipCode: String
    let parqueadero: Bool
    let vestidores: Bool
    let bar: Bool
    let banos: Bool
    let duchas: Bool
    let latitude: Double
    let longitude: Double
    let phone: String
}
