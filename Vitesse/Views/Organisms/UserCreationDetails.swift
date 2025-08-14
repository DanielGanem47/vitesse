//
//  UserCreationDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct UserCreationDetails: View {
    @State var user: NetworkUser = NetworkUser(id: UUID(),
                                               firstName: "",
                                               lastName: "",
                                               email: "",
                                               password: "",
                                               confirmedPassword: "")
    
    var body: some View {
        ScrollView {
            VStack() {
                TextFieldWithTitle(title: "First Name",
                                   placeholder: "First Name",
                                   storedValue: $user.firstName)

                TextFieldWithTitle(title: "Last Name",
                                   placeholder: "Last Name",
                                   storedValue: $user.lastName)

                EmailFieldWithTitle(title: "Email",
                                    placeholder: "Email",
                                    storedValue: $user.email)

                PasswordFieldWithTitle(title: "Password",
                                       placeholder: "Password",
                                       storedValue: $user.password)

                PasswordFieldWithTitle(title: "Confirm",
                                       placeholder: "Confirm password",
                                       storedValue: $user.confirmedPassword)
            }
        }
        .padding(50)
    }
}

#Preview {
    var user: NetworkUser = NetworkUser(id: UUID(),
                                        firstName: "",
                                        lastName: "",
                                        email: "",
                                        password: "",
                                        confirmedPassword: "")
    UserCreationDetails(user: user)
}
