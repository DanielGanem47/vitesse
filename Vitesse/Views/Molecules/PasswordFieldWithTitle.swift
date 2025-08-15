//
//  PasswordFieldWithTitle.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct PasswordFieldWithTitle: View {
    var title: String
    var placeholder: String
    @Binding var storedValue: String
    
    init(title: String, placeholder: String, storedValue: Binding<String>) {
        self.title = title
        self.placeholder = placeholder
        self._storedValue = storedValue
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            
            SecureField(placeholder,
                        text: $storedValue,
                        prompt: Text("Required"))
                .padding(4)
                .frame(height: 30)
        }
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    PasswordFieldWithTitle(title: "Password",
                           placeholder: "Password",
                           storedValue: .constant(""))
}
