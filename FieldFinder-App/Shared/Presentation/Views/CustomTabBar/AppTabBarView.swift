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
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.systemGroupedBackground

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.systemGroupedBackground

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    
    var body: some View {
        TabView(selection: $tabSelection) {
           
            Tab("Inicio", systemImage: "house.fill", value: tabSelection) {
                PlayerView(viewModel: viewModel)
            }
            
            
            Tab("Mapa", systemImage: "map.fill", value: tabSelection) {
                MapEstablishmentsView()
            }
            
            Tab("Inicio", systemImage: "person.fill", value: tabSelection) {
                DefaultProfile()
            }
            
        }
        .tint(.primaryColorGreen)
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
