//
//  CandidateDetailsForm.swift
//  Vitesse
//
//  Created by daniel ganem on 02/07/2025.
//

import SwiftUI

struct CandidateDetailsForm: View {
    @ObservedObject var candidate: CandidateDTO
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(candidate.name)
                .font(.title)

            HStack {
                Text("Phone")
                    .font(.title2)

                Spacer()
                
                Text(candidate.phoneNumber)
            }
            
            HStack {
                Text("Email")
                    .font(.title2)

                Spacer()
                
                Text(candidate.email)
            }
            
            HStack {
                Text("LinjedIn")
                    .font(.title2)

                Spacer()
                
                CustomButton(text: candidate.linkedInUrl,
                             symbol: "",
                             color: .blue) {
                    // Faire qqc
                }
            }
            
            Text("Note")
                .font(.title2)
            Text(candidate.note)
                .font(.footnote)
                .padding()
        }
    }
}

#Preview {
    var candidate: CandidateDTO = CandidateDTO(id: UUID(),
                                               name: "Daniel G.",
                                               phoneNumber: "06 37 93 62 65",
                                               email: "daniel.ganem@icloud.com",
                                               linkedInUrl: "www.linkedin.com",
                                               note: "",
                                               isFavorite: true)
    CandidateDetailsForm(candidate: candidate)
}
