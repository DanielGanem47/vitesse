final class NetworkDependenciesContainer: CustomDependenciesContainer {
    var authenticationService: any AuthenticationService = NetworkAuthenticationService()
    var candidatesRepository = CandidatesRepository()
    var userService: any UserService = NetworkUserService()
}
