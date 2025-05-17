//
//  ProfileUserViewModel.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 14/5/25.
//

import Foundation

@Observable
final class ProfileUserViewModel {
    
    var getMeData = GetMeModel(
        email: "",
        id: "",
        rol: "",
        name: "",
        establecimiento: [EstablecimientoReponse.init(
            longitude: 0.0,
            info: "",
            address: "",
            fotos: [""],
            parquedero: false,
            userName: "",
            id: "",
            name: "",
            zipCode: "",
            city: "",
            canchas: [CanchaResponse.init(
                tipo: "",
                modalidad: "",
                id: "",
                cubierta: false,
                iluminada: false,
                precio: 0,
                fotos: [""]
            )],
            phone: "",
            vestidores: false,
            duchas: false,
            userRol: "",
            banos: false,
            bar: false,
            country: "",
            latitude: 0.0
        )]
    )
    
    var messageError = ""
    
    
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
    
    @MainActor
    func updateUser(name: String) async throws {
        _ = try await useCase.updateUser(name: name)
    }
    
    @MainActor
    func delete() async throws {
        _ = try await useCase.deleteUser()
    }
}
