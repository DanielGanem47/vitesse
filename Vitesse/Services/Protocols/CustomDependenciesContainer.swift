protocol CustomDependenciesContainer {
    var authenticationService: AuthenticationService { get }
    var candidatesRepository: CandidatesRepository { get }
    var userService: UserService { get }
}
