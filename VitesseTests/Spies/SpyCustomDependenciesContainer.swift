@testable import Vitesse

struct SpyCustomDependenciesContainer: CustomDependenciesContainer {
    var authenticationRepository: Vitesse.AuthenticationRepository
    
    var candidatesRepository: Vitesse.CandidatesRepository = SpyCandidatesRepository()

    var userRepository: Vitesse.UserRepository
    

}

