import Foundation

protocol NetworkUploadPhotosEstablishmentProtocol {
    func uploadImages(establishmentID: UUID, images: [Data]) async throws
}


final class NetworkUploadPhotosEstablishment: NetworkUploadPhotosEstablishmentProtocol {
    func uploadImages(establishmentID: UUID, images: [Data]) async throws {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.uploadImagesEstablishment.rawValue)/\(establishmentID)"
        
        guard let url = URL(string: urlString) else {
            throw FFError.badUrl
        }
        
        let boundary = UUID().uuidString
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: HttpMethods.contentTypeID)
        
        let jwtToken = KeyChainFF().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        
        var body = Data()
        
        for (index, imageData) in images.enumerated() {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image\(index).jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let serverMessage = String(data: data, encoding: .utf8) ?? "Sin mensaje del servidor"
                print("Error al subir imágenes: \(serverMessage)")
                throw FFError.errorFromApi(statusCode: 500)
            }
            
            let responseMessage = String(data: data, encoding: .utf8) ?? "Subida completada"
            print("✅ Imágenes subidas correctamente: \(responseMessage)")
        } catch {
            print("❌ Error al subir las imágenes: \(error.localizedDescription)")
            throw FFError.requestWasNil
        }
    }
    
    
}
