//
//  GetFieldDetailRepository.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import Foundation

final class GetFieldDetailRepository: GetFieldDetailRepositoryProtocol {
    private var network: NetworkFieldDetailProtocol
    
    init(network: NetworkFieldDetailProtocol = NetworkFieldDetail()) {
        self.network = network
    }
    
    func getFieldDetail(with fieldId: String) async throws -> Cancha {
        return try await network.getFieldDetail(with: fieldId)
    }
}
