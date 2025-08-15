#if DEBUG
final class PreviewsDependenciesContainer: CustomDependenciesContainer {
    var authenticationRepository = AuthenticationRepository()
    var candidatesRepository = CandidatesRepository()
    var userRepository = UserRepository()
}
#endif
