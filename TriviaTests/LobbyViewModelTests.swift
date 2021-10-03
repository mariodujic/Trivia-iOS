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
    
    func test_returns_empty_string_as_initial_question_number_input() {
        let expectedValue = ""
        let actualValue = self.sut.questionNumber
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_returns_true_as_question_number_input_is_valid() {
        sut.questionNumber = "12"
        XCTAssertTrue(sut.validQuestionNumber)
    }
    
    func test_returns_false_as_question_number_input_is_not_digits_only() {
        sut.questionNumber = "12a"
        XCTAssertFalse(sut.validQuestionNumber)
    }
    
    func test_returns_false_as_question_number_input_is_empty() {
        sut.questionNumber = ""
        XCTAssertFalse(sut.validQuestionNumber)
    }
}
