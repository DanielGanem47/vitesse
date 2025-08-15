//
//  CandidateDetailsStatic.swift
//  Vitesse
//
//  Created by daniel ganem on 03/07/2025.
//

import SwiftUI

struct CandidateDetailsStatic: View {
    private var isAdmin: Bool
    var candidate: CandidateDTO
    private let onFavoriteStatusChange: (() -> Void)?
    
    @ObservedObject private var candidatesViewModel: CandidatesViewModel
    @State var isFavorite: Bool
    
    init(candidate: CandidateDTO, dependenciesContainer: NetworkDependenciesContainer, candidatesViewModel: CandidatesViewModel, isAdmin: Bool, onFavoriteStatusChange: (() -> Void)? = nil) {
        self.candidate = candidate
        self.isFavorite = candidate.isFavorite
        self.candidatesViewModel = candidatesViewModel
        self.isAdmin = isAdmin
        self.onFavoriteStatusChange = onFavoriteStatusChange
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Name")) {
                    HStack {
                        Text(candidatesViewModel.getDisplayedNameFor(networkCandidate: candidate))
                            .font(.title)
                        
                        Spacer()
                        
                        if isAdmin {
                            Button("", systemImage: isFavorite ? "star.fill" : "star") {
                                Task {
                                    isFavorite.toggle()
                                    candidate.isFavorite = isFavorite
                                    onFavoriteStatusChange?()
                                    try await candidatesViewModel.toggleFavoriteFor(candidate: candidate)
                                }
                            }
                        } else {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                        }
                    }
                }
                
                Section(header: Text("Details")) {
                    HStack {
                        Text("Phone")
                        
                        Spacer()
                        
                        //                        Link("\(candidate.phone)",
                        //                             destination: URL(string: "tel://\(candidate.phone)")!)
                        Text(candidate.phone)
                            .monospacedDigit()
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Text("Email")
                        
                        Spacer()
                        
                        //                        Link("\(candidate.email)",
                        //                             destination: URL(string: "mailto://\(candidate.email)")!)
                        Text(candidate.email)
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Text("LinkedIn")
                        
                        Spacer()
                        
                        if let urlString = candidate.linkedinURL, let url = URL(string: urlString) {
                            CustomButton(text: "Go on LinkedIn",
                                         symbol: "",
                                         color: .blue) {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                }
                            }
                                         .frame(width: 200)
                        } else {
                            Text("No LinkedIn available")
                                .foregroundStyle(.secondary)
                                .frame(width: 200)
                        }
                    }
                }
                
                Section(header: Text("Note")) {
                    Text(candidate.note ?? "")
                        .frame(alignment: .top)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#if DEBUG

#Preview {
    var candidate: CandidateDTO = CandidateDTO(id: UUID(),
                                               firstName: "Daniel 1",
                                               lastName: "Ganem",
                                               phone: "06 37 93 62 65",
                                               email: "daniel.ganem@icloud.com",
                                               linkedin_url: "www.linkedin.com",
                                               note: "kjhza dfkljsmglfjkmfslgjk lksdjg lms jdklsdkjglkjsg ml jmlgsjk sld jglkj ljldsfgkj ljgdslfj gsdljg lsffdj lmdgjs lfglkjds glgkj lkjsgd lgjdskg sdsdglfkj lfsdjk s lsgdfjljks dgsl j",
                                               isFavorite: true)
    var dependenciesContainer = NetworkDependenciesContainer()
    var candidatesViewModel = CandidatesViewModel(dependenciesContainer: PreviewsDependenciesContainer())
    CandidateDetailsStatic(candidate: candidate,
                           dependenciesContainer: dependenciesContainer,
                           candidatesViewModel: candidatesViewModel,
                           isAdmin: dependenciesContainer.authenticationRepository.isAdmin())
}

#endif
