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
    
    func test_returns_correct_default_question_number_input() {
        let expectedValue = 10
        let actualValue = self.sut.questionNumber
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_returns_true_as_question_number_input_is_valid() {
        sut.questionNumber = 10
        XCTAssertTrue(sut.validQuestionNumber)
    }
    
    func test_returns_false_as_question_number_input_is_invalid() {
        sut.questionNumber = 0
        XCTAssertFalse(sut.validQuestionNumber)
    }
}
