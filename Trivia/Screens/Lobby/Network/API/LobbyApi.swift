import Foundation
import Combine

protocol LobbyApi {
    func get(amount: Int) -> AnyPublisher<QuizResponse, Error>
}
