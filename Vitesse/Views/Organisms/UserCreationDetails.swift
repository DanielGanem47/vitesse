//
//  UserCreationDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct UserCreationDetails: View {
    var user: User = User()
    
    var body: some View {
        VStack() {
            TextFieldWithTitle(user: user, title: "First Name", placeholder: "First Name", isPassword: false)
            
            TextFieldWithTitle(user: user, title: "Last Name", placeholder: "Last Name", isPassword: false)
            
            TextFieldWithTitle(user: user, title: "Email", placeholder: "Email", isPassword: false)
            
            TextFieldWithTitle(user: user, title: "Password", placeholder: "Password", isPassword: true)
            
            TextFieldWithTitle(user: user, title: "Confirm password", placeholder: "Confirm password", isPassword: true)
        }
        .padding(50)
    }
}

#Preview {
    UserCreationDetails()
}
