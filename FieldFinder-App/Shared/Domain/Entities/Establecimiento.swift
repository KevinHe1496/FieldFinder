//
//  GetAllEstablishments.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//
import Foundation

struct Establecimiento: Codable, Identifiable {
    let id: String
    let name: String
    let info: String
    let address: String
    let city: String
    let isFavorite: Bool
    let zipCode: String
    let country: String
    let phone: String
    let userName: String
    let userRol: String
    let parquedero: Bool
    let vestidores: Bool
    let banos: Bool
    let duchas: Bool
    let bar: Bool
    let fotos: [String]
    let latitude: Double
    let longitude: Double
    let canchas: [Cancha]
    
    var photoEstablishment: [URL] {
        fotos.compactMap { url in
            URL(string: "\(url)")
        }
    }
    
    static let sample = Establecimiento(
        id: "12345",
        name: "Cancha Los Libertadores",
        info: "Complejo deportivo con canchas de fútbol 7 y servicios adicionales.",
        address: "Av. Amazonas y Naciones Unidas",
        city: "Quito",
        isFavorite: true,
        zipCode: "170102",
        country: "Ecuador",
        phone: "+593987654321",
        userName: "kevin_heredia",
        userRol: "Dueño",
        parquedero: true,
        vestidores: true,
        banos: true,
        duchas: false,
        bar: true,
        fotos: [
            "https://fieldfinder-uploads.s3.us-east-2.amazonaws.com/establecimiento/AB5C5912-B724-45D9-9652-82CC28F060F8-italia.png",
            "https://fieldfinder-uploads.s3.us-east-2.amazonaws.com/establecimiento/0C86D230-290A-4183-BBDD-D9E6133B02A3-calzone.png"
        ],
        latitude: 0.0,
        longitude: 0.0,
        canchas: [
            Cancha(
                id: "cancha001",
                tipo: "Fútbol 7",
                modalidad: "Partido completo",
                precio: 30,
                cubierta: true,
                iluminada: true,
                fotos: [
                    "/uploads/cancha1.jpg",
                    "/uploads/cancha1b.jpg"
                ]
            )
        ]
    )
    
}

struct GetNearbyEstablishmentsRequest: Codable {
    let latitude: Double
    let longitude: Double
}
