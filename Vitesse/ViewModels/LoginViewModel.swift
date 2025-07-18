//
//  LoginViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var login = LoginDTO(email: "",
                                    password: "")
    @Published var tokenAdmin = TokenAdminDTO(token: "",
                                              isAdmin: false)
    @Published var isLogged = false
    @Published var authenticatedUser: UserDTO = UserDTO(id: UUID(),
                                                        firstName: "",
                                                        lastName: "",
                                                        email: "admin@vitesse.com",
                                                        password: "test123")
    @Published var loginError: String? = nil
    
    private let executeDataRequest: (URLRequest) async throws -> (Data, URLResponse)

    init(executeDataRequest: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)) {
        self.executeDataRequest = executeDataRequest
    }

    // MARK: Login
    private func getTokenAndAdmin() async throws -> TokenAdminDTO {
        guard let url = URL(string: "http://localhost:8080/user/auth") else {
            throw URLError(.badURL)
        }

        let request = try URLRequest(
            url: url,
            method: .POST,
            parameters: [
                "email": authenticatedUser.email,
                "password": authenticatedUser.password
            ]
        )

        let (data, _) = try await executeDataRequest(request)

        return try JSONDecoder().decode(TokenAdminDTO.self,
                                        from: data)
    }
    
    func login(email:String, password: String) async  {
        do {
            let token: TokenAdminDTO = try await getTokenAndAdmin()
            Task { @MainActor in
                print("Token: \(token.token)")
                print("isAdmin: \(token.isAdmin)")
                tokenAdmin.token = token.token
                tokenAdmin.isAdmin = token.isAdmin
                isLogged = true
                loginError = nil
            }
        } catch {
            Task { @MainActor in
                loginError = "Erreur de connexion: \(error.localizedDescription)"
                isLogged = false
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
