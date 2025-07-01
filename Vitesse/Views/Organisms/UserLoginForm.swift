//
//  UserLoginDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct UserLoginForm: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TextFieldUserWithTitle(title: "Email/username", placeholder: "Email/username", isPassword: false, loginViewModel: loginViewModel)
            
            TextFieldUserWithTitle(title: "Password", placeholder: "Password", isPassword: true, loginViewModel: loginViewModel)
            
            Button("Forget password?") {
                // Action
            }
        }
    }
}

#Preview {
    var loginViewModel: LoginViewModel = LoginViewModel()
    UserLoginForm(loginViewModel: loginViewModel)
}
