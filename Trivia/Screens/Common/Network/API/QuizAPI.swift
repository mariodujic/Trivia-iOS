import Foundation
import Combine

protocol QuizApi {
    func get(amount: Int) -> AnyPublisher<QuizResponse, Error>
}
