//
//  UserCreationDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct UserCreationDetails: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack() {
            TextFieldUserWithTitle(title: "First Name", placeholder: "First Name", isPassword: false, loginViewModel: loginViewModel)
            
            TextFieldUserWithTitle(title: "Last Name", placeholder: "Last Name", isPassword: false, loginViewModel: loginViewModel)
            
            TextFieldUserWithTitle(title: "Email", placeholder: "Email", isPassword: false, loginViewModel: loginViewModel)
            
            TextFieldUserWithTitle(title: "Password", placeholder: "Password", isPassword: true, loginViewModel: loginViewModel)
            
            TextFieldUserWithTitle(title: "Confirm password", placeholder: "Confirm password", isPassword: true, loginViewModel: loginViewModel)
        }
        .padding(50)
    }
}

#Preview {
    var loginViewModel: LoginViewModel = LoginViewModel()
    UserCreationDetails(loginViewModel: loginViewModel)
}
