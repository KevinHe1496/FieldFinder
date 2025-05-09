//
//  PlayerView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 9/5/25.
//

import SwiftUI

struct PlayerView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                
            }
            .searchable(text: $searchText)
            .navigationTitle("Canchas")
        }
    }
}

#Preview {
    PlayerView()
}
