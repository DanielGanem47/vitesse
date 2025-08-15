//
//  UserRepository.swift
//  Vitesse
//
//  Created by daniel ganem on 15/08/2025.
//

import Foundation

final class UserRepository {
    private let service: any UserService

    init(service: any UserService = NetworkUserService()) {
        self.service = service
    }

    // MARK: - Functions
}
