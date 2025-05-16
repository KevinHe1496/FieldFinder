import Foundation

protocol NetworkGetMeProtocol {
    func getUser() async throws -> GetMeModel
    func updateUser(name: String) async throws -> updateUserModel
    func deleteUser() async throws
}

final class NetworkGetMe: NetworkGetMeProtocol {
    func getUser() async throws -> GetMeModel {
        var userModel = GetMeModel(email: "", id: "", rol: "", name: "", establecimiento: [])
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.getMe.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw FFError.badUrl
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        let jwtToken = KeyChainFF().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("\(HttpHeader.bearer) \(jwtToken)", forHTTPHeaderField: HttpHeader.authorization)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse, res.statusCode == HttpResponseCodes.SUCCESS else {
                throw FFError.errorFromApi(statusCode: -1)
            }
            
            let result = try JSONDecoder().decode(GetMeModel.self, from: data)
            
            userModel = result
            
        } catch {
            throw FFError.errorParsingData
        }
        
        
        return userModel
    }
    func updateUser(name: String) async throws -> updateUserModel {
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.getMe.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw FFError.badUrl
        }
        
        let requestBody = updateUserModel(name: name)
        let jsonData = try JSONEncoder().encode(requestBody)
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.put
        request.setValue(HttpHeader.content, forHTTPHeaderField: HttpHeader.contentTypeID)
        
        let jwtToken = KeyChainFF().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("\(HttpHeader.bearer) \(jwtToken)", forHTTPHeaderField: HttpHeader.authorization)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Ensure the response is a valid HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw FFError.errorFromApi(statusCode: -1) // Throw an error if the response is invalid
        }
        // Check the status code of the response
        guard httpResponse.statusCode == HttpResponseCodes.SUCCESS else {
            throw FFError.errorFromApi(statusCode: httpResponse.statusCode) // Throw an error if the status code indicates failure
        }
        
        do {
            let result = try JSONDecoder().decode(updateUserModel.self, from: data)
            return result
        } catch {
            print("Error update User name: \(error.localizedDescription)")
            throw FFError.dataNoReveiced
        }
    }
    
    func deleteUser() async throws {
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.getMe.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw FFError.badUrl
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.delete
        
        let jwtToken = KeyChainFF().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("\(HttpHeader.bearer) \(jwtToken)", forHTTPHeaderField: HttpHeader.authorization)
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse, res.statusCode == HttpResponseCodes.SUCCESS else {
                throw FFError.errorFromApi(statusCode: -1)
            }
        }
    }
}
