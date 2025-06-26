//
//  CandidateRow.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateListRow: View {
    let candidate: Candidate
    
    var body: some View {
        Text(candidate.name)
            .frame(alignment: .leading)
        Image(systemName: candidate.isFavorite ? "star.fill" : "star")
            .tint(.yellow)
            .frame(alignment: .trailing)
    }
}

#Preview {
    CandidateListRow(candidate: Candidate())
}
