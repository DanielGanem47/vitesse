//
//  SpyUserRepository.swift
//  VitesseTests
//
//  Created by daniel ganem on 22/08/2025.
//

import Foundation
@testable import Vitesse

class SpyUserRepository: UserRepository {
    var hasCalledCreateUser: Bool = false
    
    override func createUser(user: UserDTO) async throws -> Bool {
        hasCalledCreateUser = true
        return hasCalledCreateUser
    }
}
