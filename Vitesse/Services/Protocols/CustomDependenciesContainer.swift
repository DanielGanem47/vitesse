protocol CustomDependenciesContainer {
    var authenticationService: AuthenticationService { get }
    var candidateService: CandidateService { get }
    var userService: UserService { get }
}

