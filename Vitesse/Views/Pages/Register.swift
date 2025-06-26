//
//  Register.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct Register: View {
    var user: User = User()
    
    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .fontDesign(.default)
                .fontWeight(.bold)

            VStack(alignment: .leading) {
                UserCreationDetails(user: user)

                CustomButton(text: "Create",
                             symbol: "",
                             color: .blue)
                .padding(40)
            }
        }
        .padding()
    }
}

#Preview {
    Register(user: User())
}
