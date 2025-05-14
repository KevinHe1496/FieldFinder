//
//  GetFieldDetailRepositoryProtocol.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import Foundation

protocol GetFieldDetailRepositoryProtocol {
    func getFieldDetail(with fieldId: String) async throws -> Cancha
}
