//
//  UserCreationDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct UserCreationDetails: View {
    @ObservedObject var user: UserDTO
    
    var body: some View {
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
            
            PasswordFieldWithTitle(title: "Confirm password",
                                   placeholder: "Confirm password",
                                   storedValue: $user.confirmedPassword)
        }
        .padding(50)
    }
}

#Preview {
    var user: UserDTO = UserDTO(id: UUID(),
                                firstName: "",
                                lastName: "",
                                email: "",
                                password: "")
    UserCreationDetails(user: user)
}
