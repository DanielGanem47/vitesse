//
//  CandidateDetailsForm.swift
//  Vitesse
//
//  Created by daniel ganem on 02/07/2025.
//

import SwiftUI

struct CandidateDetailsForm: View {
    @ObservedObject var candidate: CandidateDTO
    @State var isFavorite: Bool
    
    @Environment(\.editMode) private var editMode
    
    var candidatesViewModel: CandidatesViewModel

    init(candidate: CandidateDTO, candidatesViewModel: CandidatesViewModel) {
        self.candidate = candidate
        self.isFavorite = candidate.isFavorite
        self.candidatesViewModel = candidatesViewModel
    }
    
    var body: some View {
        NavigationView {
            if editMode?.wrappedValue.isEditing == true {
                CandidateDetailsEditable(candidate: candidate)
                    .onDisappear {
                        Task {
                            try await candidatesViewModel.updateCandidate(candidate: candidate)
                        }
                    }
            } else {
                CandidateDetailsStatic(candidate: candidate,
                                       candidatesViewModel: candidatesViewModel)
            }
        }
    }
}

#Preview {
    var viewModel: CandidatesViewModel = CandidatesViewModel()
    var candidate: CandidateDTO = CandidateDTO(id: UUID(),
                                               firstName: "Daniel 1",
                                               lastName: "Ganem",
                                               phone: "06 37 93 62 65",
                                               email: "daniel.ganem@icloud.com",
                                               linkedin_url: "www.linkedin.com",
                                               note: "kjhza dfkljsmglfjkmfslgjk lksdjg lms jdklsdkjglkjsg ml jmlgsjk sld jglkj ljldsfgkj ljgdslfj gsdljg lsffdj lmdgjs lfglkjds glgkj lkjsgd lgjdskg sdsdglfkj lfsdjk s lsgdfjljks dgsl j",
                                               isFavorite: true)
    CandidateDetailsForm(candidate: candidate,
                         candidatesViewModel: viewModel)
}
