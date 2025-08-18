//
//  Register.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct Register: View {
    @Environment(\.dependenciesContainer) private var dependenciesContainer

    var user: NetworkUser = NetworkUser(id: UUID(),
                                        firstName: "",
                                        lastName: "",
                                        email: "",
                                        password: "",
                                        confirmedPassword: "")
    
    @State private var refresh = false
    @State private var showAlertCreationMessageAlert: Bool = false
    @State private var showAlertPasswordMessageAlert: Bool = false
    @State private var redraw = true

    var body: some View {
        VStack {
            Text("Register new user")
                .font(.largeTitle)
                .fontDesign(.default)
                .fontWeight(.bold)
            
            VStack(alignment: .leading) {
                UserCreationDetails(user: user)
                    .padding(10)

                CustomButton(text: "Create",
                             symbol: "",
                             color: .blue) {
                    if user.password == user.confirmedPassword {
                        Task {
                            let created = try await dependenciesContainer.userRepository.createUser(user: user)
                            if !created {
                                showAlertCreationMessageAlert = true
                            } else {
                                user.reset()
                                refresh.toggle()
                            }
                        }
                    } else {
                        showAlertPasswordMessageAlert = true
                    }
                }
                             .padding(40)
            }
        }
        .id(refresh)
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
