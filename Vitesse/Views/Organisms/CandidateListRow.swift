//
//  CandidateRow.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

protocol CandidateService {
    var candidates: [CandidateDTO] { get }

    func populateCandidates() async
    func update(candidate: CandidateDTO, with updatedCandidate: CandidateDTO)
}

final class CandidateServiceImplementation: CandidateService {
    var candidates: [CandidateDTO] = []
    
    func populateCandidates() async {
        // TODO: Fetch candidates from backend and populate local array
    }

    func update(candidate: CandidateDTO, with updatedCandidate: CandidateDTO) {
        guard let indexOfExistingCandidate = candidates.firstIndex(where: { $0.email == updatedCandidate.email }) else {
            return
        }

        candidates[indexOfExistingCandidate] = updatedCandidate
    }
}

struct CandidateListRow: View {
    @ObservedObject
    var candidate: CandidateDTO

    private let isEditing: Bool

    init(candidate: CandidateDTO, isEditing: Bool) {
        self.candidate = candidate
        self.isEditing = isEditing
    }
    
    var body: some View {
        HStack {
            if isEditing {
                Button("",
                       systemImage: candidate.isSelected ? "checkmark.circle" : "circle") {
                    candidate.isSelected.toggle()
                }
            }
            
            Text(candidate.name)
                .frame(alignment: .leading)
            
            Spacer()
            
            Button("",
                   systemImage: candidate.isFavorite ? "star.fill" : "star") {
                candidate.isFavorite.toggle()
            }
        }
        .padding()
    }
}

//#Preview("Default mode") {
//    NavigationStack {
//        CandidateListRow(
//            candidate: CandidateDTO(
//                id: UUID(),
//                name: "Daniel G.",
//                phoneNumber: "06 37 93 62 65",
//                email: "daniel.ganem@icloud.com",
//                linkedInUrl: "www.linkedin.com",
//                note: "tres bon eleve",
//                isFavorite: true
//            )
//        )
//        .environment(\.editMode, .constant(.active))
//    }
//}

