//
//  CandidateDetailsEditable.swift
//  Vitesse
//
//  Created by daniel ganem on 03/07/2025.
//

import SwiftUI

struct CandidateDetailsEditable: View {
    var candidate: NetworkCandidate
    var viewModel: CandidatesViewModel
    
    @State var isFavorite: Bool
    @State var phone: String
    @State var email: String
    
    init(candidate: NetworkCandidate, viewModel: CandidatesViewModel) {
        self.candidate = candidate
        self.viewModel = viewModel
        self.isFavorite = candidate.isFavorite
        self.phone = candidate.phone
        self.email = candidate.email
    }

    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Name")) {
                    Text(viewModel.getDisplayedNameFor(networkCandidate: candidate))
                        .font(.title)
                }

                Section(header: Text("Details")) {
                    PhoneFieldWithTitle(title: "Phone",
                                        placeholder: "Phone",
                                        storedValue: $phone)
                    
                    EmailFieldWithTitle(title: "Email",
                                        placeholder: "Email",
                                        storedValue: $email)
                    
                    TextFieldWithTitle(title: "LinkedIn",
                                       placeholder: "LinkedIn",
                                       storedValue: Binding(
                                        get: { candidate.linkedinURL ?? "" },
                                        set: { candidate.linkedinURL = $0.isEmpty ? nil : $0 }
                                       ))
                }
                
                Section(header: Text("Note")) {
                    TextEditor(text: Binding(
                        get: { candidate.note ?? "" },
                        set: { candidate.note = $0.isEmpty ? nil : $0 }
                    ))
                        .padding(4)
                        .frame(height: 300, alignment: .top)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black)
                        )
                }
            }
        }
    }
}

#Preview {
    let viewModel = CandidatesViewModel()
    var candidate: NetworkCandidate = NetworkCandidate(id: UUID(),
                                                       firstName: "Daniel 1",
                                                       lastName: "Ganem",
                                                       phone: "06 37 93 62 65",
                                                       email: "daniel.ganem@icloud.com",
                                                       linkedin_url: "www.linkedin.com",
                                                       note: "kjhza dfkljsmglfjkmfslgjk lksdjg lms jdklsdkjglkjsg ml jmlgsjk sld jglkj ljldsfgkj ljgdslfj gsdljg lsffdj lmdgjs lfglkjds glgkj lkjsgd lgjdskg sdsdglfkj lfsdjk s lsgdfjljks dgsl j",
                                                       isFavorite: true)
    CandidateDetailsEditable(candidate: candidate,
                             viewModel: viewModel)
}
