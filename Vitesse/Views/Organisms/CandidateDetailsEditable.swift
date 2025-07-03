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
                Text(candidate.name)
                    .font(.title)
                    .frame(height: 70, alignment: .top)

                TextFieldWithTitle(title: "Phone",
                                   placeholder: "Phone",
                                   isPassword: false,
                                   storedValue: $candidate.phoneNumber)
                
                TextFieldWithTitle(title: "Email",
                                   placeholder: "Email",
                                   isPassword: false,
                                   storedValue: $candidate.email)
                
                TextFieldWithTitle(title: "LinkedIn",
                                   placeholder: "LinkedIn",
                                   isPassword: false,
                                   storedValue: $candidate.linkedInUrl)
                
                Text("Note")
                    .font(.title2)
                
                TextEditor(text: $candidate.note)
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

#Preview {
    var candidate: CandidateDTO = CandidateDTO(id: UUID(),
                                               name: "Daniel G.",
                                               phoneNumber: "06 37 93 62 65",
                                               email: "daniel.ganem@icloud.com",
                                               linkedInUrl: "www.linkedin.com",
                                               note: "kjhza dfkljsmglfjkmfslgjk lksdjg lms jdklsdkjglkjsg ml jmlgsjk sld jglkj ljldsfgkj ljgdslfj gsdljg lsffdj lmdgjs lfglkjds glgkj lkjsgd lgjdskg sdsdglfkj lfsdjk s lsgdfjljks dgsl j",
                                               isFavorite: true)
    CandidateDetailsEditable(candidate: candidate)
}
