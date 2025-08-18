import SwiftUI

final class NetworkDependenciesContainer: CustomDependenciesContainer {
    @ObservedObject var authenticationRepository = AuthenticationRepository()
    var candidatesRepository = CandidatesRepository()
    var userRepository = UserRepository()
}
