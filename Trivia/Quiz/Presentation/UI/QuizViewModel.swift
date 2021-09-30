import Foundation
import Combine

class QuizViewModel: ObservableObject {
    
    @Published private(set) var state: State = State.Loading
    @Published private(set) var triviaQuestions: [TriviaQuestion]? = nil
    @Published private(set) var currentQuestionIndex: Int = 0
    @Published private(set) var selectedAnswers: [String?] = []
    
    var cancellable: AnyCancellable? = nil
    let triviaApi: QuizAPI
    let triviaUiMapper: QuizQuestionsUiMapper
    
    init(triviaApi: QuizAPI, triviaUiMapper: QuizQuestionsUiMapper) {
        self.triviaApi = triviaApi
        self.triviaUiMapper = triviaUiMapper
        getQuestions()
    }
    
    private func getQuestions() {
        self.cancellable = self.triviaApi.get(amount: 10)
            .sink( receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("Success")
                case .failure(_):
                    self?.state = State.Error
                }
                self?.cancellable?.cancel()
            }, receiveValue: { value in
                self.triviaQuestions = self.triviaUiMapper.map(questions: value.results)
                self.state = State.Success
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
        currentQuestionIndex+1 != triviaQuestions?.count
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
