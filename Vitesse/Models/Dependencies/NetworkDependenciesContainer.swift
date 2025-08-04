final class NetworkDependenciesContainer: CustomDependenciesContainer {
    var authenticationService: any AuthenticationService = NetworkAuthenticationService()
    var candidateService: any CandidateService = NetworkCandidateService()
    var userService: any UserService = NetworkUserService()
}
