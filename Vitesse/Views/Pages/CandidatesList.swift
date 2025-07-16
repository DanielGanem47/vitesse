//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {
    @ObservedObject var candidates: Candidates = Candidates(list: [
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: true),
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: true),
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: false),
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: false),
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: false),
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: true)
    ])

    @ObservedObject var candidatesViewModel: CandidatesViewModel = CandidatesViewModel()
    
    @State private var isEditing = false
    @Binding var isLoggedIn: Bool
    
    init(isLoggedIn: Binding<Bool>) {
        self._isLoggedIn = isLoggedIn
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(candidates.list) { candidate in
                    if isEditing {
                        CandidateListRow(candidate: candidate,
                                         isEditing: isEditing)
                    } else {
                        NavigationLink(destination: CandidateDetails(candidate: candidate)) {
                            CandidateListRow(candidate: candidate,
                                             isEditing: isEditing)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading,
                            content: {
                    Button {
                        isLoggedIn.toggle()
                    } label: {
                        Text(" Logout")
                    }
                })
                
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button {
                        isEditing.toggle()
                    } label: {
                        Text(isEditing ? "Done" : "Edit")
                    }
                })
                    
                ToolbarItem(placement: .topBarTrailing,
                            content: {
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
                })
            }
            .navigationTitle("Candidates")
        }
    }
}

#Preview("Default mode") {
    CandidatesList(isLoggedIn: .constant(true))
}
