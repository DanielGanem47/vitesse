//
//  TextFieldWithTitle.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct TextFieldUserWithTitle: View {
    @Binding var storedValue: String
    
    var title: String = ""
    var placeholder: String = ""
    var isPassword: Bool = false
    
    init(title: String, placeholder: String, isPassword: Bool, storedValue: String) {
        self.storedValue = storedValue
        self.title = title
        self.placeholder = placeholder
        self.isPassword = isPassword
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
            
            Spacer()
                .frame(height:1)
            
            if isPassword {
                SecureField(placeholder, text: $storedValue)
                    .padding(4)
                    .frame(height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.black)
                    )
            } else {
                TextField(placeholder, text: $storedValue)
                    .padding(4)
                    .frame(height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.black)
                    )
            }
        }
    }
}

#Preview {
    var loginViewModel: LoginViewModel = LoginViewModel()
    TextFieldUserWithTitle(title: "Email/username", placeholder: "Email/username", isPassword: false, storedValue: loginViewModel.authenticatedUser.email)
    TextFieldUserWithTitle(title: "Password", placeholder: "Password", isPassword: true, storedValue: loginViewModel.authenticatedUser.password)
}
