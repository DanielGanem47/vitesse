//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {

    @Environment(\.dependenciesContainer)
    private var dependenciesContainer: DependenciesContainer

    @ObservedObject
    var candidatesViewModel = CandidatesViewModel()

    @State private var isEditing = false
    @State private var showFavorites = false
    @State private var deleteCandidates = false
    @State private var isLoading = true
    
    var loginViewModel: LoginViewModel
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel

        candidatesViewModel.tokenAdmin = loginViewModel.tokenAdmin
    }

    var body: some View {
        NavigationStack {
            if isLoading {
                VStack {
                    ProgressView()
                    Text("Loading...")
                }
                .task {
                    candidatesViewModel.initWith(dependenciesContainer: dependenciesContainer)

                    await loadTable()
                }
            } else {
                List {
                    if deleteCandidates {
                        ForEach(candidatesViewModel.candidatesToDisplay) { candidate in
                            if isEditing {
                                CandidateListRow(candidate: candidate,
                                                 isEditing: isEditing)
                            } else {
                                NavigationLink(destination: CandidateDetails(candidate: candidate,
                                                                             candidatesViewModel: candidatesViewModel)) {
                                    CandidateListRow(candidate: candidate,
                                                     isEditing: isEditing)
                                }
                            }
                        }
                    } else {
                        ForEach(candidatesViewModel.candidatesToDisplay) { candidate in
                            if isEditing {
                                CandidateListRow(candidate: candidate,
                                                 isEditing: isEditing)
                            } else {
                                NavigationLink(destination: CandidateDetails(candidate: candidate,
                                                                             candidatesViewModel: candidatesViewModel)) {
                                    CandidateListRow(candidate: candidate,
                                                     isEditing: isEditing)
                                }
                            }
                        }
                    }
                }
                .refreshable {
                    Task {
                        await loadTable()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading,
                                content: {
                        Button {
                            loginViewModel.isLogged = false
                        } label: {
                            Text(" Logout")
                        }
                    })
                    
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
    var loginViewModel: LoginViewModel = LoginViewModel()
    CandidatesList(loginViewModel: loginViewModel)
}
