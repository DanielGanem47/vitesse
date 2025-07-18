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
                Section(header: Text("Name")) {
                    HStack {
                        Text(candidate.displayedName)
                            .font(.title)
                        
                        Spacer()
                        
                        Button("",
                               systemImage: isFavorite ? "star.fill" : "star") {
                            isFavorite.toggle()
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
                        
                        CustomButton(text: "Go on LinkedIn",
                                     symbol: "",
                                     color: .blue) {
                            // Faire qqc
                        }
                                     .frame(width: 200)
                    }
                }
                
                Section(header: Text("Note")) {
                    Text(candidate.note)
                        .frame(alignment: .top)
                        .foregroundStyle(.secondary)
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
    CandidateDetailsStatic(candidate: candidate)
}
