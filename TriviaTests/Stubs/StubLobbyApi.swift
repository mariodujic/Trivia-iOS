import Combine
@testable import Trivia

class StubLobbyApi: LobbyApi {
    
    func get(amount: Int) -> AnyPublisher<QuizResponse, Error> {
        return Just(QuizResponse(responseCode: 200, results: fakeQuestions))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
