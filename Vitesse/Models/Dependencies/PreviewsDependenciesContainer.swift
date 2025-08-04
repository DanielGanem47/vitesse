#if DEBUG
final class PreviewsDependenciesContainer: CustomDependenciesContainer {
    var candidateService: any CandidateService = NetworkCandidateService()
    var authenticationService: any AuthenticationService = NetworkAuthenticationService()
    var userService: any UserService = NetworkUserService()
}
#endif
