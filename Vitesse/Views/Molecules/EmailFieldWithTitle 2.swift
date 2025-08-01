//
//  PhoneFieldWithTitle.swift
//  Vitesse
//
//  Created by daniel ganem on 24/06/2025.
//

import SwiftUI

struct PhoneFieldWithTitle: View {
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
                .font(.title2)
            
            Spacer()
                .frame(height:1)
            
            TextField(placeholder,
                      text: $storedValue)
            .keyboardType(.phonePad)
                .padding(4)
                .frame(height: 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.black)
                )
        }
    }
}

#Preview {
    PhoneFieldWithTitle(title: "Email",
                        placeholder: "Email",
                        storedValue: .constant(""))
}
