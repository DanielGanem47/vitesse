//
//  UserLoginDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct UserLoginForm: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var showChangePasswordMessageAlert: Bool = false
    @State var resetPasswordEmail: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            EmailFieldWithTitle(title: "Email",
                                placeholder: "Email",
                                storedValue: $loginViewModel.authenticatedUser.email)
            
            PasswordFieldWithTitle(title: "Password",
                                   placeholder: "Password",
                                   storedValue: $loginViewModel.authenticatedUser.password)
            
            Button("Forget password?") {
                showChangePasswordMessageAlert = true
            }
        }
        .alert("Reset password",
               isPresented: $showChangePasswordMessageAlert) {
            TextField("Email", text: $resetPasswordEmail)
                .padding(4)
                .frame(height: 30)
        }
        message: {
            Text("Enter an email address to receive a link to reset your password.")
        }
    }
}

#Preview {
    var loginViewModel: LoginViewModel = LoginViewModel()
    UserLoginForm(loginViewModel: loginViewModel)
}
