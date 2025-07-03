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
    
    @Environment(\.editMode)
    private var editMode

    init(candidate: CandidateDTO) {
        self.candidate = candidate
        self.isFavorite = candidate.isFavorite
    }
    
    var body: some View {
        if editMode?.wrappedValue == .active {
            CandidateDetailsEditable(candidate: candidate)
        } else {
            CandidateDetailsStatic(candidate: candidate)
        }
    }
}

#Preview {
    var candidate: CandidateDTO = CandidateDTO(id: UUID(),
                                               name: "Daniel G.",
                                               phoneNumber: "06 37 93 62 65",
                                               email: "daniel.ganem@icloud.com",
                                               linkedInUrl: "www.linkedin.com",
                                               note: "kjhza dfkljsmglfjkmfslgjk lksdjg lms jdklsdkjglkjsg ml jmlgsjk sld jglkj ljldsfgkj ljgdslfj gsdljg lsffdj lmdgjs lfglkjds glgkj lkjsgd lgjdskg sdsdglfkj lfsdjk s lsgdfjljks dgsl j",
                                               isFavorite: true)
    CandidateDetailsForm(candidate: candidate)
}
