import Foundation

protocol NetworkRegisterProtocol {
    func registerUsers(name: String, email: String, password: String, rol: String) async throws -> String
}

struct NetworkRegister: NetworkRegisterProtocol {
    func registerUsers(name: String, email: String, password: String, rol: String) async throws -> String {
        var tokenJWT = ""
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.registerUsers.rawValue)"
        
        // Construct the URL for the consumer registration endpoint
        guard let url = URL(string: urlString) else {
            throw FFError.badUrl
        }
        
        // Create the request body with the user details
        let requestBody = RegisterUserRequest(name: name, email: email, password: password, rol: rol)
        let jsonData = try JSONEncoder().encode(requestBody)
        
        // Create the URL Request
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.setValue(HttpHeader.content, forHTTPHeaderField: HttpHeader.contentTypeID)
        request.httpBody = jsonData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse, res.statusCode == HttpResponseCodes.SUCCESS else {
                throw FFError.errorFromApi(statusCode: -1)
            }
            
            let result = try JSONDecoder().decode(LoginResponse.self, from: data)
            
            tokenJWT = result.accessToken
            
            
        } catch {
            throw FFError.errorParsingData
        }
        
        
        return tokenJWT
    }
    
    
}
