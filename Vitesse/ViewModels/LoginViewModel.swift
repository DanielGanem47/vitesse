//
//  LoginViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation

class LoginViewModel: ObservableObject {
    private var dependenciesContainer: DependenciesContainer?

    private let executeDataRequest: (URLRequest) async throws -> (Data, URLResponse)

    init(executeDataRequest: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)) {
        self.executeDataRequest = executeDataRequest
    }

    func initWith(dependenciesContainer: DependenciesContainer) {
        self.dependenciesContainer = dependenciesContainer
    }

    // MARK: Login
    
    func login(email:String, password: String) async  {
        guard let authenticatedUser = await dependenciesContainer?.authenticationService.authenticationManager.authenticatedUser,
        let authenticationService = dependenciesContainer?.authenticationService else {
            return
        }
                                                                                               
        do {
            try await authenticationService.authenticate(email: authenticatedUser.email, password: authenticatedUser.password)

            Task { @MainActor in
                dependenciesContainer?.authenticationService.authenticationManager.isLogged = true
                dependenciesContainer?.authenticationService.authenticationManager.loginError = nil
            }
        } catch {
            Task { @MainActor in
                dependenciesContainer?.authenticationService.authenticationManager.loginError = "Erreur de connexion: \(error.localizedDescription)"
                dependenciesContainer?.authenticationService.authenticationManager.isLogged = false
            }
        }
    }
}

// MARK: Mocks
extension LoginViewModel {
    func mock() async throws -> LoginViewModel {
        return LoginViewModel(executeDataRequest: LoginViewModel.mockAuthAdmin)
    }
    
    func mockNoData() async throws -> LoginViewModel {
        return LoginViewModel(executeDataRequest: LoginViewModel.mockAuthAdminNoData)
    }
    
    // Define a mock for executeDataRequest that returns predefined data
    static func mockAuthAdmin(_ request: URLRequest) async throws -> (Data, URLResponse) {
        let sampleResponseJSON = """
        {
            "token": "FfdfsdfdF9fdsf.fdsfdf98FDkzfdA3122.J83TqjxRzmuDuruBChNT8sMg5tfRi5iQ6tUlqJb3M9U",
            "isAdmin": true
        }
        """
        
        let data = sampleResponseJSON.data(using: .utf8)!
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (data, response)
    }
    
    // Define a mock for executeDataRequest that noData
    static func mockAuthAdminNoData(_ request: URLRequest) async throws -> (Data, URLResponse) {
        let sampleJSON = ""
        
        let data = sampleJSON.data(using: .utf8)!
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (data, response)
    }
}
