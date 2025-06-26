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
            NavigationStack() {
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
                    UserLoginForm(user: user)
                    
                    Spacer()

                    NavigationLink(destination: CandidatesList(), label: {
                        CustomButton(text: "Sign in",
                                     symbol: "",
                                     color: .blue)
                    })
                    
                    Spacer()
                        .frame(height: 10)
                    
                    NavigationLink(destination: Register(), label: {
                        CustomButton(text: "Register",
                                     symbol: "",
                                     color: .blue)
                    })
                }
                .padding(40)
            }
            .padding()
        }
    }
}

#Preview {
    Login()
}
