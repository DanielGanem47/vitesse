#if DEBUG
import SwiftUI

final class PreviewsDependenciesContainer: CustomDependenciesContainer {
    @ObservedObject var authenticationRepository = AuthenticationRepository()
    var candidatesRepository = CandidatesRepository()
    var userRepository = UserRepository()
}
#endif
