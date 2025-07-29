protocol CustomDependenciesContainer {
    var authenticationService: AuthenticationService { get }

    var candidateRepository: CandidateRepository { get }
}
