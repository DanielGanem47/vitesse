//
//  Login.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

struct Login: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
    }

    var body: some View {
        if !loginViewModel.isLogged {
            LoginView(loginViewModel: loginViewModel)
        } else {
            CandidatesList(loginViewModel: loginViewModel)
        }
    }
}

#Preview {
    var loginViewModel: LoginViewModel = LoginViewModel()
    Login(loginViewModel: loginViewModel)
}
