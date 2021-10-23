import Combine
import Foundation

struct LobbyAPI: LobbyAPIProviding {
    
    let client: HttpClient
    
    func fetchQuiz(amount: Int) -> AnyPublisher<QuizResponse, Error> {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "opentdb.com"
        urlComponents.path = "/api.php"
        urlComponents.queryItems = [URLQueryItem(name: "amount", value: String(amount))]
        
        return client.perform(URLRequest(url: urlComponents.url!))
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
