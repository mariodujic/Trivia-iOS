import Combine
import Foundation

struct LobbyApiImpl: LobbyApi {
    
    let client: HttpClient
    
    func get(amount: Int) -> AnyPublisher<QuizResponse, Error> {
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
