//
//  CustomButtonLoginRegister.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 8/5/25.
//


import SwiftUI

struct CustomButtonLoginRegister: View {
    
    var title: String
    var color: Color
    var textColor: Color
    var action: () -> Void
    
    
    var body: some View {
        Button(title, action: action)
            .font(.appButton)
            .padding()
            .foregroundStyle(textColor)
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(.buttonBorder)
    }
}

#Preview {
    CustomButtonLoginRegister(title: "Login", color: .primaryColorGreen, textColor: .white, action: {})
}
