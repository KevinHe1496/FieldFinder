import SwiftUI

struct CustomTextFieldLogin: View {
    let titleKey: String
    @Binding var textField: String
    var keyboardType: UIKeyboardType
    var prompt: Text
    
    var body: some View {
        
        TextField(titleKey, text: $textField, prompt: prompt)
            .font(.appDescription)
            .foregroundStyle(.primary)
            .padding()
            .background(.thirdColorWhite)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .keyboardType(keyboardType)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
    }
}

#Preview {
    CustomTextFieldLogin(titleKey: "Email", textField: .constant(""), keyboardType: .emailAddress, prompt: Text("Email"))
}
