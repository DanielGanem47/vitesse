//
//  CandidateListToolbar.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateListToolbar: View {
    @Environment(\.editMode) private var editMode

    var body: some View {
        HStack {
            EditButton()
            
            if editMode?.wrappedValue.isEditing == true {
                Button("",
                       systemImage: "trash") {
                    // Faire qqc
                }
            } else {
                Button("",
                       systemImage: "star") {
                    // Faire qqc
                }
            }
        }
    }
}

#Preview {
    CandidateListToolbar()
}
