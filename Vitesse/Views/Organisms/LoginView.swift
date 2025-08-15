//
//  LoginView.swift
//  Vitesse
//
//  Created by daniel ganem on 04/07/2025.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dependenciesContainer) private var dependenciesContainer: NetworkDependenciesContainer
    
    @State private var showLoginFailedAlert: Bool = false
    @State private var register: Bool = false
    @State private var imageOffset: CGFloat = -UIScreen.main.bounds.width / 2
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Vitesse")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: imageOffset)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            imageOffset = 0
                        }
                    }
                
                Text("Login")
                    .font(.largeTitle)
                    .fontDesign(.default)
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(height: 40)
                
                VStack(alignment: .leading) {
                    UserLoginForm()
                    
                    Spacer()
                    
                    CustomButton(text: "Sign in",
                                 symbol: "",
                                 color: .blue) {
                        Task {
                            let logged = try await dependenciesContainer.authenticationRepository.login(email: dependenciesContainer.authenticationRepository.getConnectedUser().email,
                                                                                                        password: dependenciesContainer.authenticationRepository.getConnectedUser().password)
                            if !logged {
                                showLoginFailedAlert = true
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    CustomButton(text: "Register",
                                 symbol: "",
                                 color: .blue) {
                        register = true
                    }
                }
                .padding(40)
                .navigationDestination(isPresented: $register, destination: {
                    Register()
                })
                .alert("Login failed", isPresented: $showLoginFailedAlert) {
                }
                message: {
                    Text("Please check your credentials.")
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
