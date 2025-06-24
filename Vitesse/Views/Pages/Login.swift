//
//  Login.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

struct Login: View {
    @State var navigated: Bool = false
    
    @StateObject private var user: User = User()

    var body: some View {
        VStack {
            NavigationStack() {
                Image("Vitesse")
                Text("Login")
                    .font(.largeTitle)
                    .fontDesign(.default)
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(height: 40)
                
                VStack(alignment: .leading) {
                    UserLoginForm(user: user)
                    
                    Spacer()
                    
                    CustomButton(text: "Sign in",
                                 symbol: "",
                                 color: .blue) {
                        // Action
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    CustomButton(text: "Register",
                                 symbol: "",
                                 color: .blue) {
                        // Action
                        navigated.toggle()
                    }
                }
                .padding(40)
                .navigationDestination(isPresented: $navigated) {
                    Register(user: user)
                }
            }
            .padding()
        }
    }
}

#Preview {
    Login()
}
