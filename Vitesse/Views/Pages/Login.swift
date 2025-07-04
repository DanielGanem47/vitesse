//
//  Login.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

struct Login: View {
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel(executeDataRequestTokenAdmin: LoginViewModel.mockAuthAdmin)
    
    var body: some View {
        if !loginViewModel.isLogged {
            LoginView(loginViewModel: loginViewModel)
        } else {
            CandidatesList()
        }
    }
}

#Preview {
    Login()
}
