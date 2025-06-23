//
//  Login.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

struct Login: View {
    @StateObject private var user: User = User()

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .fontDesign(.default)
                .fontWeight(.bold)
            Spacer()
                .frame(height: 100)
            VStack(alignment: .leading) {
                Text("Email/username")
                    .font(.title2)
                TextField("Email/username", text: $user.name)
                    .textFieldStyle(.roundedBorder)
                
                Text("Password")
                    .font(.title2)
                TextField("Password", text: $user.password)
                    .textFieldStyle(.roundedBorder)
                
                Button("Forget password?") {
                    // Action
                }
                
                Spacer()
                    .frame(height:50)
                
                VStack(alignment: .center) {
                    CustomButton(text: "Sign in",
                                 symbol: "",
                                 color: .blue) {
                    }
                    
                    Spacer()
                        .frame(height:20)
                    
                    CustomButton(text: "Register",
                                 symbol: "",
                                 color: .blue) {
                    }
                }
            }
            .padding()
            
        }
    }
}

#Preview {
    Login()
}
