//
//  GetEstablishmentDetailProtocol.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 12/5/25.
//

import Foundation

protocol GetEstablishmentDetailProtocol {
    func getEstablishmentDetail(with establishmentId: String) async throws -> EstablishmentResponse
}
