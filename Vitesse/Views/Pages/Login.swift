//
//  Login.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

struct Login: View {
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()
    
    @Binding var isLoggedIn: Bool

    init(isLoggedIn: Binding<Bool>) {
        self._isLoggedIn = isLoggedIn
    }

    var body: some View {
        if !loginViewModel.isLogged {
            LoginView(loginViewModel: loginViewModel)
        } else {
            CandidatesList(isLoggedIn: $isLoggedIn)
        }
    }
}

#Preview {
    Login(isLoggedIn: .constant(false))
}
