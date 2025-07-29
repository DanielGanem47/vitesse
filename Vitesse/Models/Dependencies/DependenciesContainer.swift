final class DependenciesContainer: CustomDependenciesContainer {
    let authenticationService: any AuthenticationService = NetworkAuthenticationService()
    let candidateRepository = CandidateRepository()
}
