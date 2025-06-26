//
//  CandidateDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateDetails: View {
    let candidate: Candidate
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CandidateDetails(candidate: Candidate(id: "1", name: "Daniel G.", phoneNumber: "06 37 93 62 65", email: "daniel.ganem@icloud.com", linkedInUrl: "www.linkedin.com", Note: "tres bon eleve", isFavorite: true))
}
