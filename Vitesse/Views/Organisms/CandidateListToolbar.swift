//
//  CandidateListToolbar.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateListToolbar: View {
    var body: some View {
        HStack {
            EditButton()
            Image(systemName: "star")
                .frame(alignment: .trailing)
        }
    }
}

#Preview {
    CandidateListToolbar()
}
