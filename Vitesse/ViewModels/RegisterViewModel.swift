//
//  RegisterViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var loginViewModel: LoginViewModel = LoginViewModel()

    func sendUserToServer() async {
        guard let url = URL(string: "http://localhost:8080/users") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(loginViewModel.authenticatedUser)
            request.httpBody = jsonData
            
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("Serveur a répondu avec code : \(httpResponse.statusCode)")
            }
        } catch {
            print("Erreur d’envoi : \(error)")
        }
    }
}
