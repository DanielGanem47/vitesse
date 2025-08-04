//
//  UserService.swift
//  Vitesse
//
//  Created by daniel ganem on 04/08/2025.
//

protocol UserService {
    var authenticationManager: AuthenticationManager { get }
    
    func createUser(user: UserDTO) async throws -> Bool
}
