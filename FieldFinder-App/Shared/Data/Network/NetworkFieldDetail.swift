//
//  NetworkFieldDetail.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import Foundation

protocol NetworkFieldDetailProtocol {
    func getFieldDetail(with fieldId: String) async throws -> CanchaResponse
}

final class NetworkFieldDetail: NetworkFieldDetailProtocol {
    func getFieldDetail(with fieldId: String) async throws -> CanchaResponse {
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.getFieldById.rawValue)/\(fieldId)"
        
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
            let result = try JSONDecoder().decode(CanchaResponse.self, from: data)
            return result
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            throw FFError.decodingError
        }
    }
}
