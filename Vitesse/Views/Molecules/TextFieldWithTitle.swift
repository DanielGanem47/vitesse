//
//  TextFieldWithTitle.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct TextFieldWithTitle: View {
    @ObservedObject var user: User = User()
    var title: String = ""
    var placeholder: String = ""
    var isPassword: Bool = false
    
    init(user: User, title: String, placeholder: String, isPassword: Bool) {
        self.user = user
        self.title = title
        self.placeholder = placeholder
        self.isPassword = isPassword
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
            
            Spacer()
                .frame(height:-10)
            
            if isPassword {
                SecureField(placeholder, text: $user.password)
                    .padding(4)
                    .frame(height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.black)
                    )
            } else {
                TextField(placeholder, text: $user.firstName)
                    .padding(4)
                    .frame(height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.black)
                    )
            }
        }
    }
}

#Preview {
    var user: User = User()
    TextFieldWithTitle(user: user, title: "Email/username", placeholder: "Email/username", isPassword: false)
    TextFieldWithTitle(user: user, title: "Password", placeholder: "Password", isPassword: true)
}
