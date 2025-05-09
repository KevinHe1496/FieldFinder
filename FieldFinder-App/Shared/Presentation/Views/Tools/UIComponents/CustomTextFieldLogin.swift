import SwiftUI

struct CustomTextFieldLogin: View {
    let titleKey: String
    @Binding var textField: String
    var keyboardType: UIKeyboardType
    var prompt: Text
    var Bgcolor: Color
    
    var body: some View {
        
        TextField(titleKey, text: $textField, prompt: prompt)
            .font(.appDescription)
            .padding()
            .background(Bgcolor)
            .clipShape(.buttonBorder)
            .keyboardType(keyboardType)
        
    }
}

#Preview {
    CustomTextFieldLogin(titleKey: "Email", textField: .constant("example@example.com"), keyboardType: .emailAddress, prompt: Text("Email"), Bgcolor: .gray)
}
