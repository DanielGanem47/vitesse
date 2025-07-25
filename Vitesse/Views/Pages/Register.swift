//
//  Register.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct Register: View {
    let register: RegisterViewModel = RegisterViewModel()

    @ObservedObject var user: UserDTO = UserDTO(id: UUID(),
                                                firstName: "",
                                                lastName: "",
                                                email: "",
                                                password: "")
    @State private var showAlertCreationMessageAlert: Bool = false
    @State private var showAlertPasswordMessageAlert: Bool = false

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
                             color: .blue) {
                    if user.password == user.confirmedPassword {
                        Task {
                            let created = try await register.createUser(user: user)
                            if !created {
                                showAlertCreationMessageAlert = true
                            } else {
                                user.reset()
                            }
                        }
                    } else {
                        showAlertPasswordMessageAlert = true
                    }
                }
                .padding(40)
            }
        }
        .padding()
        .alert("User creation failed",
               isPresented: $showAlertCreationMessageAlert) {
        }
        message: {
            Text("Cannot create user. Please retry.")
        }
        .alert("Wrong password",
               isPresented: $showAlertPasswordMessageAlert) {
        }
        message: {
            Text("Your password is not equal to your confirmed password.")
        }
    }
}

#Preview {
    Register()
}
