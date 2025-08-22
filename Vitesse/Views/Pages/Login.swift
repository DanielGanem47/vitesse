//
//  Login.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

struct Login: View {
    @ObservedObject var authenticationRepository: AuthenticationRepository
    @Environment(\.dependenciesContainer) private var dependenciesContainer
    
    var body: some View {
        if !authenticationRepository.isLogged {
            LoginView()
        } else {
            CandidatesList(candidatesViewModel: CandidatesViewModel(dependenciesContainer: dependenciesContainer),
                           userViewModel: UserViewModel(dependenciesContainer: dependenciesContainer))
        }
    }
}

#Preview {
    let repo = AuthenticationRepository()
    Login(authenticationRepository: repo)
}
