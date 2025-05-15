//
//  AppTabBarView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//
import SwiftUI

struct AppTabBarView: View {
    
    @State private var selection: String = "home"
    
    @State private var tabSelection: TabBarItem = .home
    @StateObject private var viewModel = GetNearbyEstablishmentsViewModel()
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            PlayerView(viewModel: viewModel)
                .tabBarItem(tab: .home, selection: $tabSelection)
            
            MapEstablishmentsView()
                .tabBarItem(tab: .map, selection: $tabSelection)
            
            ProfileUserView()
                .tabBarItem(tab: .profile, selection: $tabSelection)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    
    AppTabBarView()
        .environment(AppState())
}


extension AppTabBarView {
    private var defaultTabView: some View {
        TabView(selection: $selection) {
            
            Color.red
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            Color.blue
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            
            Color.orange
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}
