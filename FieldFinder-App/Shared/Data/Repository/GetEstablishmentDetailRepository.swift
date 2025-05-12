//
//  GetEstablishmentDetailRepository.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation

final class GetEstablishmentDetailRepository: GetEstablishmentDetailProtocol {
    private var network: NetworkEstablishmentDetailProtocol
    
    init(network: NetworkEstablishmentDetailProtocol = NetworkEstablishmentDetail()) {
        self.network = network
    }
    func getEstablishmentDetail(with establishmentId: String) async throws -> Establecimiento {
        return try await network.getEstablishmentDetail(with: establishmentId)
    }
    
}
