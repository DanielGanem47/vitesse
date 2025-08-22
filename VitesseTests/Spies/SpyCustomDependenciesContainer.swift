//
//  SpyCustomDependenciesContainer.swift
//  VitesseTests
//
//  Created by daniel ganem on 22/08/2025.
//

import Foundation
@testable import Vitesse

struct SpyCustomDependenciesContainer: CustomDependenciesContainer {
    var authenticationRepository: Vitesse.AuthenticationRepository = SpyAuthenticationRepository()
    var candidatesRepository: Vitesse.CandidatesRepository = SpyCandidatesRepository()
    var userRepository: Vitesse.UserRepository = SpyUserRepository()
}
