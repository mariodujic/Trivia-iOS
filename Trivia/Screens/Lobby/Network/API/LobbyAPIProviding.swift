import Foundation
import Combine

protocol LobbyAPIProviding {
    func fetchQuiz(amount: Int) -> AnyPublisher<QuizResponse, Error>
}
