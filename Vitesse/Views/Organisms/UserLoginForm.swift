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
            TextFieldUserWithTitle(title: "Email", placeholder: "Email", isPassword: false, storedValue: loginViewModel.authenticatedUser.email)
            
            TextFieldUserWithTitle(title: "Password", placeholder: "Password", isPassword: true, storedValue: loginViewModel.authenticatedUser.password)
            
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
