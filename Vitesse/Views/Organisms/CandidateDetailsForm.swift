//
//  CandidateDetailsForm.swift
//  Vitesse
//
//  Created by daniel ganem on 02/07/2025.
//

import SwiftUI

final class CandidateDetailsFormViewModel {

    private var dependenciesContainer: DependenciesContainer?

    func initWith(dependenciesContainer: DependenciesContainer) {
        self.dependenciesContainer = dependenciesContainer
    }

    func update(candidate: CandidateDTO) async throws {
        guard let dependenciesContainer else {
            fatalError("Missing dependenciesContainer")
        }

        try await dependenciesContainer.candidateRepository.update(candidate: candidate)
    }
}

struct CandidateDetailsForm: View {

    private let viewModel: CandidateDetailsFormViewModel

    @ObservedObject var candidate: CandidateDTO
    @State var isFavorite: Bool
    
    @Environment(\.editMode) private var editMode

    @Environment(\.dependenciesContainer)
    private var dependenciesContainer: DependenciesContainer

    init(candidate: CandidateDTO) {
        self.candidate = candidate
        self.isFavorite = candidate.isFavorite
    }
    
    var body: some View {
        NavigationView {
            if editMode?.wrappedValue.isEditing == true {
                CandidateDetailsEditable(candidate: candidate)
                    .onDisappear {
                        Task {
                            try await viewModel.update(candidate: candidate)
                        }
                    }
            } else {
                CandidateDetailsStatic(candidate: candidate)
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
    CandidateDetailsForm(candidate: candidate)
}
