//
//  CandidateListToolbarDelete.swift
//  Vitesse
//
//  Created by daniel ganem on 04/07/2025.
//

import SwiftUI

struct CandidateListToolbarDelete: View {
    var body: some View {
         HStack {
             EditButton()
             
             Button("",
                    systemImage: "trash") {
                 // Faire qqc
             }
                 .frame(alignment: .trailing)
         }
     }
}

#Preview {
    CandidateListToolbarDelete()
}
