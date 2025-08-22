//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {
    @Environment(\.dependenciesContainer) private var dependenciesContainer

    var userViewModel: UserViewModel

    @ObservedObject var candidatesViewModel: CandidatesViewModel
    @State private var isEditing = false
    @State private var showFavorites = false
    @State private var deleteCandidates = false
    @State private var isLoading = true
    @State private var searchValue: String = ""
        
    init(candidatesViewModel: CandidatesViewModel, userViewModel: UserViewModel) {
        self.candidatesViewModel = candidatesViewModel
        self.userViewModel = userViewModel
    }
    
   var body: some View {
        NavigationStack {
            if isLoading {
                VStack {
                    ProgressView()
                    Text("Loading...")
                }
                .task {
                    userViewModel.tokenAdmin = dependenciesContainer.authenticationRepository.getTokenAdmin()

                    await loadTable()
                }
            } else {
                List {
                    ForEach(candidatesViewModel.candidatesToDisplay.filter {searchValue.isEmpty || candidatesViewModel.getDisplayedNameFor(networkCandidate: $0).localizedCaseInsensitiveContains(searchValue)}) { candidate in
                        if isEditing {
                            CandidateListRow(candidate: candidate,
                                             isEditing: isEditing,
                                             candidatesViewModel: candidatesViewModel)
                        } else {
                            NavigationLink {
                                CandidateDetailsForm(candidate: candidate,
                                                     candidatesViewModel: candidatesViewModel) {
                                    candidatesViewModel.refreshList()
                                }
                            } label: {
                                 CandidateListRow(candidate: candidate,
                                                 isEditing: isEditing,
                                                 candidatesViewModel: candidatesViewModel)
                            }
                        }
                    }
                }
                .searchable(text: $searchValue,
                            prompt: "Search candidates")
                .searchPresentationToolbarBehavior(.avoidHidingContent)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading,
                                content: {
                        Button {
                            dependenciesContainer.authenticationRepository.isLoggedOut()
                        } label: {
                            Text(" Logout")
                        }
                    })
       
#if DEBUG
                    if !isEditing {
                        ToolbarItem(placement: .topBarTrailing,
                                    content: {
                            Button("",
                                   systemImage: "person.fill.badge.plus") {
                                Task {
                                    try await candidatesViewModel.initTable()
                                    isLoading = true
                                }
                            }
                        })
                    }
#endif
                    
                   ToolbarItem(placement: .topBarTrailing,
                                content: {
                        Button {
                            isEditing.toggle()
                            if !isEditing {
                                deleteCandidates = false
                            }
                        } label: {
                            Text(isEditing ? "Done" : "Edit")
                        }
                    })
                    
                    ToolbarItem(placement: .topBarTrailing,
                                content: {
                        if isEditing == true {
                            Button("",
                                   systemImage: "trash") {
                                deleteCandidates = true
                                Task {
                                    try await candidatesViewModel.deleteSelectedCandidates()
                                }
                            }
                        } else {
                            Button("", systemImage: showFavorites ? "star.fill" : "star") {
                                showFavorites.toggle()

                                if showFavorites {
                                    candidatesViewModel.filterByFavorites()
                                } else {
                                    candidatesViewModel.resetFilteredCandidates()
                                }
                            }
                        }
                    })
                }
                .navigationTitle("Candidates")
            }
        }
    }

    private func loadTable() async {
        do {
            try await candidatesViewModel.loadTable()
            isLoading = false
        } catch {
            // Handle error if needed
            print("Failed to load candidates table: \(error)")
        }
    }
}

#Preview("Default mode") {
    CandidatesList(candidatesViewModel: CandidatesViewModel(dependenciesContainer: PreviewsDependenciesContainer()),
                   userViewModel: UserViewModel(dependenciesContainer: PreviewsDependenciesContainer()))
}
