//
//  CandidatesViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation


class CandidatesViewModel: ObservableObject {
    @Published var list: [CandidateDTO] = [CandidateDTO(id: UUID(),
                                                        name: "Daniel G.",
                                                        phoneNumber: "06 37 93 62 65",
                                                        email: "daniel.ganem@icloud.com",
                                                        linkedInUrl: "www.linkedin.com",
                                                        note: "tres bon eleve",
                                                        isFavorite: true)]
}
