//
//  Login.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

struct Login: View {

    @Environment(\.dependenciesContainer) private var dependenciesContainer

    var body: some View {
        let authenticationManager = dependenciesContainer.authenticationService.authenticationManager

        Content(authenticationManager: authenticationManager)
    }
}

struct Content: View {

    @Environment(\.dependenciesContainer) private var dependenciesContainer
    @ObservedObject var authenticationManager: AuthenticationManager

    var body: some View {
        if !authenticationManager.isLogged {
            LoginView()
        } else {
            CandidatesList(candidatesViewModel: CandidatesViewModel(dependenciesContainer: dependenciesContainer))
        }
    }
}

#Preview {
    Login()
}
