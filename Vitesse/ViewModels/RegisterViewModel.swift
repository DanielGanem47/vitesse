//
//  RegisterViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation

class RegisterViewModel: ObservableObject {
    private let executeDataRequestRegisterUser: (URLRequest) async throws -> (Data, URLResponse)

    init(executeDataRequestRegisterUser: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)) {
        self.executeDataRequestRegisterUser = executeDataRequestRegisterUser
    }
}
