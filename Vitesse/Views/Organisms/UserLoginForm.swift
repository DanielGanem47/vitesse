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

    @State private var showChangePasswordMessageAlert: Bool = false
    @State var resetPasswordEmail: String = ""
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        ScrollView {
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
                email = dependenciesContainer.authenticationRepository.getConnectedUser().email
                password = dependenciesContainer.authenticationRepository.getConnectedUser().password
            })
            .onChange(of: email, { oldValue, newValue in
                dependenciesContainer.authenticationRepository.setNewEmail(email: newValue)
            })
            .onChange(of: password, { oldValue, newValue in
                dependenciesContainer.authenticationRepository.setNewPassword(password: newValue)
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
}

#Preview {
    UserLoginForm()
}
