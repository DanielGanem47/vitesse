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
        Content()
    }
}

struct Content: View {
    @Environment(\.dependenciesContainer) private var dependenciesContainer

    var body: some View {
        if !dependenciesContainer.authenticationRepository.isLogged() {
            LoginView()
        } else {
            CandidatesList(candidatesViewModel: CandidatesViewModel(dependenciesContainer: dependenciesContainer))
        }
    }
}

#Preview {
    Login()
}
