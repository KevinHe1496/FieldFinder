//
//  TabBarItem.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//


import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, map, profile, favorites
    
    var iconName: String {
        switch self {
        case .home: return "house.fill"
        case .map: return "map.fill"
        case .profile: return "person.fill"
        case .favorites: return "heart.fill"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .map: return "Mapa"
        case .profile: return "Perfil"
        case .favorites: return "Favoritos"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.white
        case .map: return Color.white
        case .profile: return Color.white
        case .favorites: return Color.white
        }
    }
}
