//
//  CandidateDetailsStatic.swift
//  Vitesse
//
//  Created by daniel ganem on 03/07/2025.
//

import SwiftUI

struct CandidateDetailsStatic: View {
    private var dependenciesContainer: NetworkDependenciesContainer?

    @ObservedObject private var viewModel: CandidateDetailsStaticViewModel
    @ObservedObject var candidate: CandidateDTO
    
    @State var isFavorite: Bool
    
    init(candidate: CandidateDTO, dependenciesContainer: NetworkDependenciesContainer) {
        self.candidate = candidate
        self.isFavorite = candidate.isFavorite
        self.dependenciesContainer = dependenciesContainer
        self.viewModel = CandidateDetailsStaticViewModel(candidate: candidate,
                                                         dependenciesContainer: dependenciesContainer)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Name")) {
                    HStack {
                        Text(viewModel.displayName)
                            .font(.title)
                        
                        Spacer()
                        
                        if viewModel.isAdmin {
                            Button("", systemImage: isFavorite ? "star.fill" : "star") {
                                Task {
                                    isFavorite.toggle()
                                    candidate.isFavorite = isFavorite
                                    try await viewModel.toggleFavorite()
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
    CandidateDetailsStatic(candidate: candidate,
                           dependenciesContainer: dependenciesContainer)
}

#endif
