//
//  CandidateDetailsEditable.swift
//  Vitesse
//
//  Created by daniel ganem on 03/07/2025.
//

import SwiftUI

struct CandidateDetailsEditable: View {
    @ObservedObject var candidate: CandidateDTO
    @State var isFavorite: Bool
    
    init(candidate: CandidateDTO) {
        self.candidate = candidate
        self.isFavorite = candidate.isFavorite
    }

    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Name")) {
                    Text(candidate.displayedName)
                        .font(.title)
                }

                Section(header: Text("Details")) {
                    TextFieldWithTitle(title: "Phone",
                                       placeholder: "Phone",
                                       storedValue: $candidate.phone)
                    
                    EmailFieldWithTitle(title: "Email",
                                        placeholder: "Email",
                                        storedValue: $candidate.email)
                    
                    TextFieldWithTitle(title: "LinkedIn",
                                       placeholder: "LinkedIn",
                                       storedValue: Binding(
                                        get: { candidate.linkedinURL ?? "" },
                                        set: { candidate.linkedinURL = $0.isEmpty ? nil : $0 }
                                       ))
                }
                
                Section(header: Text("Notes")) {
                    Text("Note")
                        .font(.title2)
                    
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
    var candidate: CandidateDTO = CandidateDTO(id: UUID(),
                                               firstName: "Daniel 1",
                                               lastName: "Ganem",
                                               phone: "06 37 93 62 65",
                                               email: "daniel.ganem@icloud.com",
                                               linkedin_url: "www.linkedin.com",
                                               note: "kjhza dfkljsmglfjkmfslgjk lksdjg lms jdklsdkjglkjsg ml jmlgsjk sld jglkj ljldsfgkj ljgdslfj gsdljg lsffdj lmdgjs lfglkjds glgkj lkjsgd lgjdskg sdsdglfkj lfsdjk s lsgdfjljks dgsl j",
                                               isFavorite: true)
    CandidateDetailsEditable(candidate: candidate)
}
