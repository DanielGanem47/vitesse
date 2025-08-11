//
//  CandidateDetailsStatic.swift
//  Vitesse
//
//  Created by daniel ganem on 03/07/2025.
//

import SwiftUI

struct CandidateDetailsStatic: View {
    private var dependenciesContainer: NetworkDependenciesContainer?
    private var candidatesViewModel: CandidatesViewModel
    private var loginViewModel: LoginViewModel
    var candidate: NetworkCandidate
    
    @State var isFavorite: Bool
    
    init(candidate: NetworkCandidate, dependenciesContainer: NetworkDependenciesContainer, candidatesViewModel: CandidatesViewModel, loginViewModel: LoginViewModel) {
        self.candidate = candidate
        self.isFavorite = candidate.isFavorite
        self.dependenciesContainer = dependenciesContainer
        self.candidatesViewModel = candidatesViewModel
        self.loginViewModel = loginViewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Name")) {
                    HStack {
                        Text(candidatesViewModel.getDisplayedNameFor(networkCandidate: candidate))
                            .font(.title)
                        
                        Spacer()
                        
                        if loginViewModel.isAdmin {
                            Button("", systemImage: isFavorite ? "star.fill" : "star") {
                                Task {
                                    isFavorite.toggle()
                                    candidate.isFavorite = isFavorite
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
    var candidate: NetworkCandidate = NetworkCandidate(id: UUID(),
                                                       firstName: "Daniel 1",
                                                       lastName: "Ganem",
                                                       phone: "06 37 93 62 65",
                                                       email: "daniel.ganem@icloud.com",
                                                       linkedin_url: "www.linkedin.com",
                                                       note: "kjhza dfkljsmglfjkmfslgjk lksdjg lms jdklsdkjglkjsg ml jmlgsjk sld jglkj ljldsfgkj ljgdslfj gsdljg lsffdj lmdgjs lfglkjds glgkj lkjsgd lgjdskg sdsdglfkj lfsdjk s lsgdfjljks dgsl j",
                                                       isFavorite: true)
    var dependenciesContainer = NetworkDependenciesContainer()
    var candidatesViewModel = CandidatesViewModel()
    var loginViewModel = LoginViewModel()
    CandidateDetailsStatic(candidate: candidate,
                           dependenciesContainer: dependenciesContainer,
                           candidatesViewModel: candidatesViewModel,
                           loginViewModel: loginViewModel)
}

#endif
