//
//  LoginViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation


class LoginViewModel: ObservableObject {
    @Published var login = LoginDTO(email: "", password: "")
    @Published var tokenAdmin = TokenAdminDTO(token: "", isAdmin: false)
    @Published var isLogged = false
    @Published var authenticatedUser: UserDTO = UserDTO(id: UUID(), firstName: "", lastName: "", email: "admin@vitesse.com", password: "test123")
    @Published var loginError: String? = nil
    
    private let executeDataRequestTokenAdmin: (URLRequest) async throws -> (Data, URLResponse)

    init(
        executeDataRequestTokenAdmin: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)
    ) {
        self.executeDataRequestTokenAdmin = executeDataRequestTokenAdmin
    }

    // MARK: Login
    private func getTokenAndAdmin() async throws -> TokenAdminDTO {
        print("getTokenAndAdmin")
        guard let url = URL(string: "http://localhost:8080/user/auth") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: String = """
        {
            "email": \(authenticatedUser.email)
            "password": \(authenticatedUser.password)
        }
        """
        request.httpBody = body.data(using: .utf8)

        let (data, _) = try await executeDataRequestTokenAdmin(request)

        return try JSONDecoder().decode(TokenAdminDTO.self, from: data)
    }
    
    func login(email:String, password: String) async  {
        print("login")
        do {
            let tokenAdmin: TokenAdminDTO = try await getTokenAndAdmin()
            Task { @MainActor in
                print("Token: \(tokenAdmin.token)")
                print("isAdmin: \(tokenAdmin.isAdmin)")
                self.isLogged = true
                self.loginError = nil
            }
        } catch {
            Task { @MainActor in
                self.loginError = "Erreur de connexion: \(error.localizedDescription)"
                self.isLogged = false
            }
        }
    }
}

// MARK: Mocks
extension LoginViewModel {
    func mock() async throws -> LoginViewModel {
        return LoginViewModel(executeDataRequestTokenAdmin: LoginViewModel.mockAuthAdmin)
    }
    
    func mockNoData() async throws -> LoginViewModel {
        return LoginViewModel(executeDataRequestTokenAdmin: LoginViewModel.mockAuthAdminNoData)
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
