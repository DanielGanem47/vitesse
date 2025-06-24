//
//  UserLoginDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct UserLoginForm: View {
    var user: User = User()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextFieldWithTitle(user: user, title: "Email/username", placeholder: "Email/username", isPassword: false)
            
            TextFieldWithTitle(user: user, title: "Password", placeholder: "Password", isPassword: true)
            
            Button("Forget password?") {
                // Action
            }
        }
    }
}

#Preview {
    UserLoginForm(user: User())
}
