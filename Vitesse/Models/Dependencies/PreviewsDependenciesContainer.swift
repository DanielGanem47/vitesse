#if DEBUG

final class PreviewsDependenciesContainer: CustomDependenciesContainer {
    var candidateRepository = CandidateRepository()
    var authenticationService = NetworkAuthenticationService(authenticationManager: AuthenticationManager()) as any AuthenticationService
}

#endif
