//
//  CandidateDetailsStatic.swift
//  Vitesse
//
//  Created by daniel ganem on 03/07/2025.
//

import SwiftUI

struct CandidateDetailsStatic: View {
    @ObservedObject var candidate: CandidateDTO
    @State var isFavorite: Bool

    init(candidate: CandidateDTO) {
        self.candidate = candidate
        self.isFavorite = candidate.isFavorite
    }

    var body: some View {
        VStack(alignment: .leading) {
            Form {
                HStack {
                    Text(candidate.name)
                        .font(.title)
                    
                    Spacer()
                    
                    Button("",
                           systemImage: isFavorite ? "star.fill" : "star") {
                        isFavorite.toggle()
                    }
                }
                
                Spacer()
                    .frame(height: 40)
                
                HStack {
                    Text("Phone")
                        .font(.title2)
                    
                    Spacer()
                    
                    Text(candidate.phoneNumber)
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("Email")
                        .font(.title2)
                    
                    Spacer()
                    
                    Text(candidate.email)
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("LinkedIn")
                        .font(.title2)
                    
                    Spacer()
                    
                    CustomButton(text: "Go on LinkedIn",
                                 symbol: "",
                                 color: .blue) {
                        // Faire qqc
                    }
                                 .frame(width: 200)
                }
                
                Text("Note")
                    .font(.title2)
                Text(candidate.note)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(alignment: .top)
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
    CandidateDetailsStatic(candidate: candidate)
}
