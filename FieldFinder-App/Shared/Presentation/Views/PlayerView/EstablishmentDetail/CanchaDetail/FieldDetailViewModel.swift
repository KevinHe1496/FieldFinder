//
//  FieldDetailViewModel.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 13/5/25.
//

import Foundation

@Observable
final class FieldDetailViewModel {
    var state: ViewState<CanchaResponse> = .idle
    
    @ObservationIgnored
    private var useCase: GetFieldDetailUseCaseProtocol
    
    init(useCase: GetFieldDetailUseCaseProtocol = GetFieldDetailUseCase()) {
        self.useCase = useCase
    }
    
    @MainActor
    func getFieldDetail(with fieldId: String) async throws {
        state = .loading
        do {
            let cancha = try await useCase.getFieldDetail(with: fieldId)
            state = .success(cancha)
        } catch {
            state = .error("No se pudo cargar la cancha.")
        }
    }
}
