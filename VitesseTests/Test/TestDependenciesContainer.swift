import SwiftUI

final class TestDependenciesContainer: CustomDependenciesContainer {
    var authenticationRepository: AuthenticationRepositoryTests { get }
    var candidatesRepository: CandidatesRepositoryTests { get }
    var userRepository: UserRepositoryTests { get }
}

extension EnvironmentValues {
    // Fake singleton
    private static let staticDependenciesContainer = TestDependenciesContainer()
    
    @Entry var dependenciesContainer = staticDependenciesContainer
}
