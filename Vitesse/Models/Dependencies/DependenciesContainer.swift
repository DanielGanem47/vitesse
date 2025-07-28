final class DependenciesContainer: CustomDependenciesContainer {
    
    var isAdmin = false

    let authenticationService: any AuthenticationService = NetworkAuthenticationService()
    let candidateRepository = CandidateRepository()
}
