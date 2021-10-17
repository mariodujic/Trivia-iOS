import Foundation

class QuizViewModel: ObservableObject {
    
    @Published private(set) var triviaQuestions: [TriviaQuestionUi]? = nil
    @Published private(set) var currentQuestionIndex: Int = 0
    @Published private(set) var selectedAnswers: [String?] = []
    
    let quizQuestionsUiMapper: QuizQuestionsNetworkToUiMapper
    
    init(quizQuestionsUiMapper: QuizQuestionsNetworkToUiMapper, triviaQuestions: [TriviaQuestion]) {
        self.quizQuestionsUiMapper = quizQuestionsUiMapper
        self.triviaQuestions = self.quizQuestionsUiMapper.map(questions: triviaQuestions)
    }
    
    var currentQuestion: String {
        (triviaQuestions?[currentQuestionIndex].question ?? "")
    }
    
    var answers: [String] {
        (triviaQuestions?[currentQuestionIndex].allAnswers)!
    }
    
    var correctAnswer: String? {
        triviaQuestions?[currentQuestionIndex].correctAnswer
    }
    
    var currentQuestionIndicator: String {
        triviaQuestions != nil ? "\(currentQuestionIndex + 1)/\(triviaQuestions?.count ?? 0)" : ""
    }
    
    var hasMoreQuestions: Bool {
        if triviaQuestions != nil {
            return currentQuestionIndex+1 < triviaQuestions!.count
        } else {
            return false
        }
    }
    
    func setSelectedAnswer(selectedAnswer: String) {
        if self.hasSelectedAnswer {
            self.selectedAnswers[currentQuestionIndex] = selectedAnswer
        } else {
            self.selectedAnswers.insert(selectedAnswer, at: currentQuestionIndex)
        }
    }
    
    var selectedAnswer: String? {
        if !hasSelectedAnswer {
            return ""
        }
        return self.selectedAnswers[currentQuestionIndex]
    }
    
    var hasSelectedAnswer: Bool {
        self.selectedAnswers.count == currentQuestionIndex + 1
    }
    
    func onNextQuestion() {
        self.currentQuestionIndex += 1
    }
    
    func getResults() -> String {
        var correctAnswerCount = 0
        for (index, answer) in selectedAnswers.enumerated() {
            if answer == self.triviaQuestions![index].correctAnswer {
                correctAnswerCount += 1
            }
        }
        return "\(correctAnswerCount)/\(triviaQuestions!.count)"
    }
}
