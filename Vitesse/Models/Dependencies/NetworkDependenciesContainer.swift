import SwiftUI

final class NetworkDependenciesContainer: CustomDependenciesContainer {
    var authenticationRepository = AuthenticationRepository()
    var candidatesRepository = CandidatesRepository()
    var userRepository = UserRepository()
}
