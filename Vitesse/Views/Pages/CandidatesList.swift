//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {
    @ObservedObject var candidatesViewModel: CandidatesViewModel = CandidatesViewModel()
    
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
                    do {
                        try await candidatesViewModel.loadTable()
                        isLoading = false
                    } catch {
                        // Handle error if needed
                        print("Failed to load candidates table: \(error)")
                    }
                }
            } else {
                List {
                    if deleteCandidates {
                        ForEach(showFavorites ? candidatesViewModel.filteredCandidates.list : candidatesViewModel.candidates.list) { candidate in
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
                        ForEach(showFavorites ? candidatesViewModel.filteredCandidates.list : candidatesViewModel.candidates.list) { candidate in
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
                            Button("",
                                   systemImage: showFavorites ? "star.fill" : "star") {
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
}

#Preview("Default mode") {
    var loginViewModel: LoginViewModel = LoginViewModel()
    CandidatesList(loginViewModel: loginViewModel)
}
