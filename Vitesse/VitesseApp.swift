//
//  VitesseApp.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

@main
struct VitesseApp: App {

    @State
    private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if !isLoggedIn {
                Login(isLoggedIn: $isLoggedIn)
            } else {
                NavigationStack {
                    CandidatesList()
                }
            }
        }
    }
}
