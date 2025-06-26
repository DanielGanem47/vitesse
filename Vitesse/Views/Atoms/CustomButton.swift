//
//  CustomButton.swift
//  ClassQuote
//
//  Created by daniel ganem on 18/06/2025.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var symbol: String
    var color: Color
   
    var body: some View {
        HStack(spacing: 10) {
            Spacer()
            Image(systemName: symbol)
            Text(text)
            Spacer()
        }
        .padding()
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .foregroundStyle(.white)
        .fontWeight(.semibold)
    }
}

#Preview {
    CustomButton(text: "Get quote",
                 symbol: "arrow.clockwise",
                 color: .blue)
}
