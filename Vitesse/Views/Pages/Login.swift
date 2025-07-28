//
//  Login.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

struct Login: View {
    @ObservedObject var loginViewModel: LoginViewModel
    let dependenciesContainer: DependenciesContainer
    
    init(dependenciesContainer: DependenciesContainer, loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        self.dependenciesContainer = dependenciesContainer
    }

    var body: some View {
        if !dependenciesContainer.authenticationService.authenticationManager.isLogged {
            LoginView(loginViewModel: loginViewModel)
        } else {
            CandidatesList(loginViewModel: loginViewModel)
        }
    }
}

#Preview {
    var loginViewModel: LoginViewModel = LoginViewModel()
    var dependenciesContainer: DependenciesContainer = DependenciesContainer()
    Login(dependenciesContainer: dependenciesContainer, loginViewModel: loginViewModel)
}
