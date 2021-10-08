import Foundation
import Combine

class LobbyViewModel: ObservableObject {
    
    @Published var lobbyState: LobbyState = .generateQuiz
    @Published var questionNumber: Int = 10
    @Published var triviaQuestions: [TriviaQuestion]? = nil
    
    var cancellable: AnyCancellable? = nil
    var triviaApi: LobbyApi
    
    init(triviaApi: LobbyApi){
        self.triviaApi = triviaApi
    }
    
    var validQuestionNumber: Bool  {
        questionNumber != 0
    }
    
    func generateQuiz(numberOfQuestions: Int, callback: @escaping (Bool)->Void) {
        self.cancellable = self.triviaApi.get(amount: numberOfQuestions)
            .sink( receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure:
                    callback(false)
                case .finished:
                    print("Success")
                }
                self?.cancellable?.cancel()
            }, receiveValue: { value in
                self.triviaQuestions = value.results
                callback(self.triviaQuestions != nil && self.triviaQuestions!.count > 0)
            })
    }
}
