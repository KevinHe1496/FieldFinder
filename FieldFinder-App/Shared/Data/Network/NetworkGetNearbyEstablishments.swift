//
//  NetworkGetAllEstablishments.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation
import CoreLocation

protocol NetworkGetNearbyEstablishmentsProtocol {
    func getAllEstablishments(coordinate: CLLocationCoordinate2D) async throws -> [Establecimiento]
}

final class NetworkGetNearbyEstablishments: NetworkGetNearbyEstablishmentsProtocol {
    func getAllEstablishments(coordinate: CLLocationCoordinate2D) async throws -> [Establecimiento] {
        var modelReturn = [Establecimiento]()
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.getNearbyEstablishments.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw FFError.badUrl
        }
        
        let requestBody = GetNearbyEstablishmentsRequest(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let jsonData = try JSONEncoder().encode(requestBody)
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.setValue(HttpHeader.content, forHTTPHeaderField: HttpHeader.contentTypeID)
        
        let jwtToken = KeyChainFF().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("\(HttpHeader.bearer) \(jwtToken)", forHTTPHeaderField: HttpHeader.authorization)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let res = response as? HTTPURLResponse, res.statusCode == HttpResponseCodes.SUCCESS else {
            throw FFError.errorFromApi(statusCode: -1)
        }
        
        do {
            let result = try JSONDecoder().decode([Establecimiento].self, from: data)
            modelReturn = result
        } catch {
            print("Decoding error: \(error.localizedDescription)")
        }
        return modelReturn
    }
}
