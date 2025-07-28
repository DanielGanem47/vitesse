//
//  CandidateDetailsStatic.swift
//  Vitesse
//
//  Created by daniel ganem on 03/07/2025.
//

import SwiftUI

final class CandidateDetailsStaticViewModel: ObservableObject {

    @Published
    private var candidate: CandidateDTO

    private var dependenciesContainer: DependenciesContainer?

    init(candidate: CandidateDTO) {
        self.candidate = candidate
    }

    var isAdmin: Bool {
        dependenciesContainer?.isAdmin ?? false
    }

    var displayName: String {
        candidate.displayedName
    }

    func initWith(dependenciesContainer: DependenciesContainer) {
        self.dependenciesContainer = dependenciesContainer
    }

    func toggleFavorite() async throws {
        guard let dependenciesContainer else {
            fatalError("missing dependenciesContainer")
        }

        try await dependenciesContainer.candidateRepository.update(candidate: candidate)
    }
}

struct CandidateDetailsStatic: View {

    private let dependenciesContainer: DependenciesContainer

    @ObservedObject
    private var viewModel: CandidateDetailsStaticViewModel

    @ObservedObject var candidate: CandidateDTO
    @State var isFavorite: Bool
    @Environment(\.openURL) private var openURL

    init(dependenciesContainer: any CustomDependenciesContainer, candidate: CandidateDTO) {
        self.candidate = candidate
        self.isFavorite = candidate.isFavorite
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
                                isFavorite.toggle()

                                Task {
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
                        
                        Text(candidate.phone)
                            .monospacedDigit()
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Text("Email")
                        
                        Spacer()
                        
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
                              openURL(url)
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
        .task {
            viewModel.initWith(dependenciesContainer: dependenciesContainer)
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
    CandidateDetailsStatic(dependenciesContainer: PreviewsDependenciesContainer(), candidate: candidate)
}

#endif
