//
//  ProfileUserViewModel.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 14/5/25.
//

import Foundation

@Observable
final class ProfileUserViewModel {
    var getMeData = GetMeModel(email: "", id: "", rol: "", name: "", establecimiento: [])
    
    @ObservationIgnored
    private var useCase: GetMeUseCaseProtocol
    
    init(useCase: GetMeUseCaseProtocol = GetMeUseCase()) {
        self.useCase = useCase
    }
    
    @MainActor
    func getMe() async throws {
        let result = try await useCase.getUser()
        self.getMeData = result
    }
}
