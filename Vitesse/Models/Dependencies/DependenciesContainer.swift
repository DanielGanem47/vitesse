import SwiftUI

final class DependenciesContainer: CustomDependenciesContainer, ObservableObject {
    @Published var authenticationService = NetworkAuthenticationService(authenticationManager: AuthenticationManager.shared)
    @Published var candidateRepository: CandidateRepository
    
    init(candidateRepository: CandidateRepository) {
        let candidateService = NetworkCandidateService(authenticationManager: AuthenticationManager.shared)
        self.candidateRepository.candidateService = candidateService
    }
}
