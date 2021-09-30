import Foundation
import Combine

struct HttpResponse<T> {
    let value: T
    let response: URLResponse
}

struct HttpClient {
    
    func perform<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<HttpResponse<T>, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .retry(3)
            .tryMap{result -> HttpResponse<T> in
                let item: T = try decoder.decode(T.self, from: result.data)
                return HttpResponse(value: item, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
