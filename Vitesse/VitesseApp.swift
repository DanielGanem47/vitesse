//
//  VitesseApp.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

@main
struct VitesseApp: App {
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()

    var body: some Scene {
        WindowGroup {
            if !loginViewModel.isLogged {
                Login(loginViewModel: loginViewModel)
            } else {
                NavigationStack {
                    CandidatesList(loginViewModel: loginViewModel)
                }
            }
        }
    }
}
