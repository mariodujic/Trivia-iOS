import XCTest
@testable import Trivia

class LobbyViewModelTests: XCTestCase {
    
    var sut: LobbyViewModel!
    
    override func setUp() {
        self.sut = LobbyViewModel()
    }
    
    func test_returns_corrent_initial_lobby_state() {
        let expectedState = LobbyState.GenerateQuiz
        let actualState = self.sut.lobbyState
        XCTAssertEqual(expectedState, actualState)
    }
}
