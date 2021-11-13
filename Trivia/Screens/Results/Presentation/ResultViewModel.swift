import Foundation

class ResultViewModel: ObservableObject {
    
    @Published private(set) var quizResult: QuizResult
    
    init(quizResult: QuizResult) {
        self.quizResult = quizResult
    }
}
