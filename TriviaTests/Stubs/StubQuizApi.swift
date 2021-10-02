import Combine
@testable import Trivia

class StubQuizApi: QuizApi {
    
    func get(amount: Int) -> AnyPublisher<QuizResponse, Error> {
        return Just(QuizResponse(responseCode: 200, results: fakeQuestions))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
