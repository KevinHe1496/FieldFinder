import Foundation

protocol NetworkRegisterEstablishmentProtocol {
    func registerEstablishment(_ establishmentModel: EstablishmentModel) async throws
}

final class NetworkRegisterEstablishment: NetworkRegisterEstablishmentProtocol {
    
    func registerEstablishment(_ establishmentModel: EstablishmentModel) async throws  {
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.registerEstablishment.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw FFError.badUrl
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.setValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        
        let jwtToken = KeyChainFF().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = try JSONEncoder().encode(establishmentModel)
        
        do {
            
            
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // 6. Verificar que la respuesta es válida y fue exitosa
            guard let httpResponse = response as? HTTPURLResponse else {
                throw FFError.errorFromApi(statusCode: -1)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                // Aquí puedes decodificar un posible mensaje de error si el backend lo envía
                if let errorMessage = String(data: data, encoding: .utf8) {
                    print("Error del servidor: \(errorMessage)")
                }
                throw FFError.errorFromApi(statusCode: httpResponse.statusCode)
            }
            
            print("✅ Establecimiento registrado con éxito.")
            
            
            
        } catch {
            print("Error al registrar: \(error.localizedDescription)")
            throw FFError.requestWasNil
        }
        
    }
    
}



