//
//  CandidateListToolbar.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateListToolbar: View {
    @Binding
    var isEditing: Bool

    init(isEditing: Binding<Bool>) {
        self._isEditing = isEditing
    }

    var body: some View {
        HStack {
            Button {
                
            } label: {
                Text("Logout")
            }

            Button {
                isEditing.toggle()
            } label: {
                Text(isEditing ? "Done" : "Edit")
            }

            if isEditing == true {
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

//#Preview {
//    CandidateListToolbar()
//}
