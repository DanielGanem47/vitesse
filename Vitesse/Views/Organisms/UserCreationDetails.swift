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
            TextFieldUserWithTitle(title: "First Name", placeholder: "First Name", isPassword: false, storedValue: loginViewModel.authenticatedUser.firstName)
            
            TextFieldUserWithTitle(title: "Last Name", placeholder: "Last Name", isPassword: false, storedValue: loginViewModel.authenticatedUser.lastName)
            
            TextFieldUserWithTitle(title: "Email", placeholder: "Email", isPassword: false, storedValue: loginViewModel.authenticatedUser.email)
            
            TextFieldUserWithTitle(title: "Password", placeholder: "Password", isPassword: true, storedValue: loginViewModel.authenticatedUser.password)
            
            TextFieldUserWithTitle(title: "Confirm password", placeholder: "Confirm password", isPassword: true, storedValue: loginViewModel.authenticatedUser.password)
        }
        .padding(50)
    }
}

#Preview {
    var loginViewModel: LoginViewModel = LoginViewModel()
    UserCreationDetails(loginViewModel: loginViewModel)
}
