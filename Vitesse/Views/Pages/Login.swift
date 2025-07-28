//
//  Login.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

struct Login: View {
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel(executeDataRequestTokenAdmin: LoginViewModel.mockAuthAdmin)
    @State private var register: Bool = false
    @State private var showLoginFailedAlert: Bool = false

    @Binding
    private var isLoggedIn: Bool

    init(isLoggedIn: Binding<Bool>) {
        self._isLoggedIn = isLoggedIn
    }

    var body: some View {
        NavigationStack() {
            VStack {
                Image("Vitesse")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Login")
                    .font(.largeTitle)
                    .fontDesign(.default)
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(height: 40)
                
                VStack(alignment: .leading) {
                    UserLoginForm(loginViewModel: loginViewModel)
                    
                    Spacer()
                    
                    CustomButton(text: "Sign in",
                                 symbol: "",
                                 color: .blue) {
                        Task {
                            await loginViewModel.login(email: loginViewModel.authenticatedUser.email,
                                                       password: loginViewModel.authenticatedUser.password)
                            if !loginViewModel.isLogged {
                                showLoginFailedAlert = true
                            } else {
                                isLoggedIn = true
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
                } message: {
                    Text("Please check your credentials.")
                }
            }
            .padding()
        }
    }
}

//#Preview {
//    Login()
//}
