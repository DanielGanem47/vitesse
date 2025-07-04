//
//  CandidateListToolbar.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateListToolbar: View {
    @Environment(\.editMode)
    private var editMode

   var body: some View {
        HStack {
            if editMode?.wrappedValue == .active {
                EditButton()
                
                Button("",
                       systemImage: "trash") {
                }
                       .frame(alignment: .trailing)
            } else {
                EditButton()
                
                Button("",
                       systemImage: "star") {
                }
                       .frame(alignment: .trailing)
            }
        }
    }
}

#Preview {
    CandidateListToolbar()
}
