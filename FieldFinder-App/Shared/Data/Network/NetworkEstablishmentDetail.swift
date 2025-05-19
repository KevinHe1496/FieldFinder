//
//  NetworkEstablishmentDetail.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation

protocol NetworkEstablishmentDetailProtocol {
    func getEstablishmentDetail(with establishmentId: String) async throws -> Establecimiento
}

final class NetworkEstablishmentDetail: NetworkEstablishmentDetailProtocol {
    func getEstablishmentDetail(with establishmentId: String) async throws -> Establecimiento {
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.getEstablishmentById.rawValue)/\(establishmentId)"
        
        guard let url = URL(string: urlString) else {
            throw FFError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Verifica que la respuesta sea válida y del tipo HTTPURLResponse.
        guard let httpResponse = response as? HTTPURLResponse else {
            throw FFError.errorFromApi(statusCode: -1)
        }
        
        // Valida que el código de respuesta HTTP sea exitoso.
        guard httpResponse.statusCode == HttpResponseCodes.SUCCESS else {
            throw FFError.errorFromApi(statusCode: httpResponse.statusCode)
        }
        
        do {
            let result = try JSONDecoder().decode(Establecimiento.self, from: data)
            return result
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            throw FFError.decodingError
        }
    }
}
