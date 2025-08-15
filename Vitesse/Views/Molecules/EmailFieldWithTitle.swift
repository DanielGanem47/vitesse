//
//  EmailFieldWithTitle.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct EmailFieldWithTitle: View {
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
            
            TextField(placeholder,
                      text: $storedValue)
                .keyboardType(.emailAddress)
                .padding(4)
                .frame(height: 30)
        }
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    EmailFieldWithTitle(title: "Email",
                        placeholder: "Email",
                        storedValue: .constant(""))
}
