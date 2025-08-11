#if DEBUG
final class TestDependenciesContainer: CustomDependenciesContainer {
    var candidateService: any CandidateService = TestCandidateService()
    var authenticationService: any AuthenticationService = TestAuthenticationService()
    var userService: any UserService = TestUserService()
}
#endif
