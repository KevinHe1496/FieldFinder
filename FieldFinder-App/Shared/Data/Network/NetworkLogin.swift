import Foundation

protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async throws -> String
}

final class NetworkLogin: NetworkLoginProtocol {
    
    
    func loginApp(user: String, password: String) async throws -> String {
        
        var tokenJWT = ""
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.login.rawValue)"
        
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        var segCredentials = ""
        
        if let credentials = encodeCredentials {
            segCredentials = "Basic \(credentials)"
        }
        
        // Request
        guard let url = URL(string: urlString) else {
            throw FFError.badUrl
        }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        
        // Headers
        request.addValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        request.addValue(segCredentials, forHTTPHeaderField: "Authorization")
        
        // Call to server
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse, res.statusCode == HttpResponseCodes.SUCCESS else {
                throw FFError.errorFromApi(statusCode: -1)
            }
            let result = try JSONDecoder().decode(LoginResponse.self, from: data)
            
            tokenJWT = result.accessToken
            
        } catch {
            print("No data response \(error.localizedDescription)")
            tokenJWT = ""
        }
        
        return tokenJWT
    }
    
    
}


// MOCK Success

final class NetworkLoginMock: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async throws -> String {
        return UUID().uuidString
    }
}
