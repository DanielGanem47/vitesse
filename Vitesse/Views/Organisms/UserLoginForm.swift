//
//  UserLoginDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct UserLoginForm: View {
    @Environment(\.dependenciesContainer)
    private var dependenciesContainer

    @ObservedObject var loginViewModel: LoginViewModel
    
    @State private var showChangePasswordMessageAlert: Bool = false
    @State var resetPasswordEmail: String = ""
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            EmailFieldWithTitle(title: "Email",
                                placeholder: "Email",
                                storedValue: $email)
            
            PasswordFieldWithTitle(title: "Password",
                                   placeholder: "Password",
                                   storedValue: $password)
            
            Button("Forget password?") {
                showChangePasswordMessageAlert = true
            }
        }
        .onAppear(perform: {
            email = dependenciesContainer.authenticationService.authenticationManager.authenticatedUser.email
            password = dependenciesContainer.authenticationService.authenticationManager.authenticatedUser.password
        })
        .onChange(of: email, { oldValue, newValue in
            dependenciesContainer.authenticationService.authenticationManager.authenticatedUser.email = newValue
        })
        .onChange(of: password, { oldValue, newValue in
            dependenciesContainer.authenticationService.authenticationManager.authenticatedUser.password = newValue
        })
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
