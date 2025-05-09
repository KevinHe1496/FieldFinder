//
//  CustomSecureFieldView.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 8/5/25.
//


import SwiftUI

struct CustomSecureFieldView: View {
    
    let titleKey: String
    @Binding var textField: String
    var keyboardType: UIKeyboardType
    var prompt: Text
    
    var body: some View {
        SecureField(titleKey, text: $textField, prompt: prompt)
            .font(.appDescription)
            .padding()
            .background(Color.thirdColorWhite)
            .clipShape(.buttonBorder)
    }
}

#Preview {
    CustomSecureFieldView(titleKey: "Password", textField: .constant("123456"), keyboardType: .default, prompt: Text("Enter your password"))
}

