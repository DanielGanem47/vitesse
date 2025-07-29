#if DEBUG

final class PreviewsDependenciesContainer: CustomDependenciesContainer {
    var isAdmin = false

    var candidateRepository = CandidateRepository()
    
    var authenticationService = NetworkAuthenticationService(authenticationManager: AuthenticationManager()) as any AuthenticationService
}

#endif
