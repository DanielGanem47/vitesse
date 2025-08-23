//
//  UserViewModelTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 22/08/2025.
//

import Foundation
import Testing
@testable import Vitesse

@Suite
struct UserViewModelTests {
    @Test func testCreateUser() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()

        // When
        let _ = try await spyContainer.userRepository.createUser(user: UserDTO(id: UUID(),
                                                                               firstName: "Daniel",
                                                                               lastName: "Ganelm",
                                                                               email: "daniel.ganem@icloud.com",
                                                                               password: "aze"))

        // Then
        #expect((spyContainer.userRepository as? SpyUserRepository)!.hasCalledCreateUser == true)
    }
    
    @Test func testGetAllUsers() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = UserViewModel(dependenciesContainer: spyContainer)
        
        // When
        model.setConnectedUser(user: UserDTO(id: UUID(),
                                             firstName: "Daniel",
                                             lastName: "Ganelm",
                                             email: "daniel.ganem@icloud.com",
                                             password: "aze"))
        
        // Then
        #expect(model.connectedUser.firstName == "Daniel")
    }
    
    @Test func tesdtIsAdmin() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = UserViewModel(dependenciesContainer: spyContainer)
        
        // Then
        #expect (model.isAdmin() == false)
    }
}
