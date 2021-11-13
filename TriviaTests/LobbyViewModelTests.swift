import XCTest
@testable import Trivia
import SwiftUI

class LobbyViewModelTests: XCTestCase {
    
    let lobbyApi: LobbyAPIProviding = StubLobbyApi()
    let storageService: StorageService = StorageService()
    var sut: LobbyViewModel!
    
    override func setUp() {
        self.sut = LobbyViewModel(triviaApi: lobbyApi, storageService: storageService)
        UserDefaults.standard.removeObject(forKey: sut.darkThemeKey)
    }
    
    func test_returns_corrent_initial_lobby_state() {
        let expectedState = LobbyState.generateQuiz
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
    
    func test_returns_initial_darkTheme_as_false() {
        XCTAssertFalse(sut.darkTheme)
    }
    
    func test_returns_darkTheme_as_true_when_toggleDarkTheme() {
        sut.toggleDarkTheme()
        XCTAssertTrue(sut.darkTheme)
    }
    
    func test_returns_initial_colorScheme_light() {
        let expectedValue: ColorScheme = .light
        let actualValue = sut.colorScheme
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_returns_colorScheme_dark_when_toggleDarkTheme() {
        let expectedValue: ColorScheme = sut.darkTheme ? .light : .dark
        sut.toggleDarkTheme()
        let actualValue = sut.colorScheme
        XCTAssertEqual(expectedValue, actualValue)
    }
}
