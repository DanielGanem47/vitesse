//
//  CandidateDetailsForm.swift
//  Vitesse
//
//  Created by daniel ganem on 02/07/2025.
//

import SwiftUI

struct CandidateDetailsForm: View {
    private let candidatesViewModel: CandidatesViewModel
    private let loginViewModel: LoginViewModel = LoginViewModel()
    var candidate: CandidateDTO
    private let onFavoriteStatusChange: (() -> Void)?

    @Environment(\.editMode) private var editMode
    @Environment(\.dependenciesContainer) private var dependenciesContainer

    init(candidate: CandidateDTO, candidatesViewModel: CandidatesViewModel, onFavoriteStatusChange: (() -> Void)? = nil) {
        self.candidate = candidate
        self.candidatesViewModel = candidatesViewModel
        self.onFavoriteStatusChange = onFavoriteStatusChange
    }
    
    var body: some View {
        NavigationView {
            if editMode?.wrappedValue.isEditing == true {
                CandidateDetailsEditable(candidate: candidate,
                                         viewModel: candidatesViewModel)
            } else {
                CandidateDetailsStatic(candidate: candidate,
                                       dependenciesContainer: dependenciesContainer,
                                       candidatesViewModel: candidatesViewModel,
                                       isAdmin: dependenciesContainer.authenticationRepository.isAdmin(),
                                       onFavoriteStatusChange: onFavoriteStatusChange)
            }
        }
        .toolbar {
            EditButton()
        }
    }
}

#Preview {
    var viewModel: CandidatesViewModel = CandidatesViewModel(dependenciesContainer: PreviewsDependenciesContainer())
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
