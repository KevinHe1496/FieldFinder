//
//  FieldDetailViewModel.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import Foundation

@Observable
final class FieldDetailViewModel {
    var fieldData = Cancha(
        id: "",
        tipo: "",
        modalidad: "",
        precio: 0,
        cubierta: false,
        iluminada: false,
        fotos: [""]
    )
    
    @ObservationIgnored
    private var useCase: GetFieldDetailUseCaseProtocol
    
    init(useCase: GetFieldDetailUseCaseProtocol = GetFieldDetailUseCase()) {
        self.useCase = useCase
    }
    
    @MainActor
    func getFieldDetail(with fieldId: String) async throws {
        let data = try await useCase.getFieldDetail(with: fieldId)
        fieldData = data
    }
}
