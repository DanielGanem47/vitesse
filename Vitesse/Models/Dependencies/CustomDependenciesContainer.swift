protocol CustomDependenciesContainer {

    var isAdmin: Bool { get }

    var authenticationService: AuthenticationService { get }

    var candidateRepository: CandidateRepository { get }
}
