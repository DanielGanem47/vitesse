//
//  UserServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI

struct UserServiceTests {
    private var service = TestUserService()

    @Test func createUser() async throws {
        let result = try await service.createUser(user: UserDTO(id: UUID(),
                                                                firstName: "",
                                                                lastName: "",
                                                                email: "",
                                                                password: ""))
        #expect (result == true)
    }

}
