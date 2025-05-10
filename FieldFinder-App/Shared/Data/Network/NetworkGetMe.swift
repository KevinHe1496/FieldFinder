import Foundation

protocol NetworkGetMeProtocol {
    func getUser() async throws -> GetMeModel
}

final class NetworkGetMe: NetworkGetMeProtocol {
    func getUser() async throws -> GetMeModel {
        var userModel = GetMeModel(email: "", id: "", rol: "", name: "")
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.getMe.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw FFError.badUrl
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        let jwtToken = KeyChainFF().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.addValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        
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
    
    
}
