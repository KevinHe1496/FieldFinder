//
//  LoginResponse.swift
//  FieldFinder-App
//
//  Created by Andy Heredia on 8/5/25.
//

import Foundation

struct LoginResponse: Codable {
    let refreshToken: String
    let accessToken: String
}
