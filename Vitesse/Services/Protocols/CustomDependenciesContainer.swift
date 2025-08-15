protocol CustomDependenciesContainer {
    var authenticationRepository: AuthenticationRepository { get }
    var candidatesRepository: CandidatesRepository { get }
    var userRepository: UserRepository { get }
}

