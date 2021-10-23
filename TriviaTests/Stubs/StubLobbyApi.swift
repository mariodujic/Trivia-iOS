import Combine
@testable import Trivia

class StubLobbyApi: LobbyAPIProviding {
    
    func fetchQuiz(amount: Int) -> AnyPublisher<QuizResponse, Error> {
        return Just(QuizResponse(responseCode: 200, results: fakeQuestions))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
