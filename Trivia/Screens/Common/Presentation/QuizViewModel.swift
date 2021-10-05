import Foundation
import Combine

class QuizViewModel: ObservableObject {
    
    @Published private(set) var triviaQuestions: [TriviaQuestion]? = nil
    @Published private(set) var currentQuestionIndex: Int = 0
    @Published private(set) var selectedAnswers: [String?] = []
    
    var cancellable: AnyCancellable? = nil
    let quizApi: QuizApi
    let quizQuestionsUiMapper: QuizQuestionsUiMapper
    
    init(triviaApi: QuizApi, triviaUiMapper: QuizQuestionsUiMapper) {
        self.quizApi = triviaApi
        self.quizQuestionsUiMapper = triviaUiMapper
    }
    
    func generateQuiz(numberOfQuestions: Int, callback: @escaping (Bool)->Void) {
        self.cancellable = self.quizApi.get(amount: numberOfQuestions)
            .sink( receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure:
                    callback(false)
                case .finished:
                    print("Success")
                }
                self?.cancellable?.cancel()
            }, receiveValue: { value in
                self.triviaQuestions = self.quizQuestionsUiMapper.map(questions: value.results)
                callback(self.triviaQuestions != nil && self.triviaQuestions!.count > 0)
            })
    }
    
    var currentQuestion: String {
        (triviaQuestions?[currentQuestionIndex].question ?? "")
    }
    
    var answers: [String] {
        var incorrectAnswers: [String]? =
            triviaQuestions?[currentQuestionIndex].incorrectAnswers
        
        if self.correctAnswer != nil && incorrectAnswers != nil {
            incorrectAnswers?.append(self.correctAnswer!)
            return incorrectAnswers!
        } else {
            return []
        }
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
}
