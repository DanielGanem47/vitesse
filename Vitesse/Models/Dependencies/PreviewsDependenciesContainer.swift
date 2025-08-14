#if DEBUG
final class PreviewsDependenciesContainer: CustomDependenciesContainer {
    var candidatesRepository = CandidatesRepository()
    var authenticationService: any AuthenticationService = NetworkAuthenticationService()
    var userService: any UserService = NetworkUserService()
}
#endif
