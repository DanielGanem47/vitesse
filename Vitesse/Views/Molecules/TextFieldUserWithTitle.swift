//
//  TextFieldWithTitle.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct TextFieldUserWithTitle: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    var title: String = ""
    var placeholder: String = ""
    var isPassword: Bool = false
    
    init(title: String, placeholder: String, isPassword: Bool, loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
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
                SecureField(placeholder, text: $loginViewModel.authenticatedUser.password)
                    .padding(4)
                    .frame(height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.black)
                    )
            } else {
                TextField(placeholder, text: $loginViewModel.authenticatedUser.email)
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
    TextFieldUserWithTitle(title: "Email/username", placeholder: "Email/username", isPassword: false, loginViewModel: loginViewModel)
    TextFieldUserWithTitle(title: "Password", placeholder: "Password", isPassword: true, loginViewModel: loginViewModel)
}
