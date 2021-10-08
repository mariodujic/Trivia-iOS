import XCTest
@testable import Trivia

class QuizViewModelTests: XCTestCase {
    
    let quizQuestionsUiMapper = QuizQuestionsUiMapper()
    var sut: QuizViewModel!
    
    override func setUp() {
        self.sut = QuizViewModel(quizQuestionsUiMapper: quizQuestionsUiMapper, triviaQuestions: fakeQuestions)
    }
    
    func test_returns_empty_array_as_initial_selected_answers() {
        let expectedList: [String] = []
        let actualList = self.sut.selectedAnswers
        XCTAssertEqual(expectedList, actualList)
    }
    
    func test_returns_correct_initial_question_index() {
        let expectedIndex = 0
        let actualIndex = self.sut.currentQuestionIndex
        XCTAssertEqual(expectedIndex, actualIndex)
    }
    
    func test_returns_correct_current_question_when_quiz_generated() {
        let expectedQuestion = fakeQuestions[0].question
        let actualQuestion = self.sut.currentQuestion
        XCTAssertEqual(expectedQuestion, actualQuestion)
    }
    
    func test_returns_all_answers_for_selected_question() {
        let expectedAnswers = ([fakeQuestions[0].correctAnswer] + fakeQuestions[0].incorrectAnswers).sorted()
        let actualAnswers = self.sut.answers.sorted()
        XCTAssertEqual(expectedAnswers, actualAnswers)
    }
    
    func test_returns_correct_answer_for_selected_question() {
        let expectedAnswer = fakeQuestions[0].correctAnswer
        let actualAnswer = self.sut.correctAnswer
        XCTAssertEqual(expectedAnswer, actualAnswer)
    }
    
    func test_returns_correct_current_question_indicator() {
        let expectedIndicator = "\(sut.currentQuestionIndex + 1)/\(sut.triviaQuestions!.count)"
        let actualIndicator = self.sut.currentQuestionIndicator
        XCTAssertEqual(expectedIndicator, actualIndicator)
    }
    
    func test_returns_true_as_quiz_has_more_question() {
        XCTAssertTrue(self.sut.hasMoreQuestions)
    }
    
    func test_returns_false_as_quiz_has_no_more_questions() {
        for _ in 0...sut.triviaQuestions!.count - 2{
            sut.onNextQuestion()
        }
        XCTAssertFalse(self.sut.hasMoreQuestions)
    }
    
    func test_returns_correct_selected_answer() {
        let expectedAnswer = fakeQuestions[0].correctAnswer
        sut.setSelectedAnswer(selectedAnswer: expectedAnswer)
        let actualAnswer = sut.selectedAnswer
        XCTAssertEqual(expectedAnswer, actualAnswer)
    }
    
    func test_returns_true_as_answer_is_selected() {
        sut.setSelectedAnswer(selectedAnswer: fakeQuestions[0].correctAnswer)
        XCTAssertTrue(sut.hasSelectedAnswer)
    }
    
    func test_returns_incremented_current_question_index() {
        XCTAssertEqual(sut.currentQuestionIndex, 0)
        sut.onNextQuestion()
        XCTAssertEqual(sut.currentQuestionIndex, 1)
    }
}
