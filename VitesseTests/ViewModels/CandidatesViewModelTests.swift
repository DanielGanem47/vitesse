
import Testing

@testable import Vitesse

@Suite
struct CandidatesViewModelTests {

    @Test
    func testDoSomething() {
        let spyContainer = SpyCustomDependenciesContainer()

        // Given
        let element = CandidatesViewModel(dependenciesContainer: spyContainer)

        // When
        element.deleteSelectedCandidates()

        // Then
        #expect((spyContainer.candidatesRepository as? SpyCandidatesRepository)!.hasCalledDeleteCandidate == true)
    }
}
