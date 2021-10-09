import Foundation
import Combine
import SwiftUI

let darkThemeKey: String = "darkThemeKey"

class LobbyViewModel: ObservableObject {
    
    @Published var lobbyState: LobbyState = .generateQuiz
    @Published var questionNumber: Int = 10
    @Published var triviaQuestions: [TriviaQuestion]? = nil
    
    var cancellable: AnyCancellable? = nil
    var triviaApi: LobbyApi
    
    @Published private(set) var darkTheme: Bool = UserDefaults.standard.bool(forKey: darkThemeKey) {
        didSet { UserDefaults.standard.set(self.darkTheme, forKey: darkThemeKey) }
    }
    
    init(triviaApi: LobbyApi){
        self.triviaApi = triviaApi
        self.registerDefaultDarkTheme()
    }
    
    private func registerDefaultDarkTheme() {
        UserDefaults.standard.register(defaults: [darkThemeKey : false])
    }
    
    func toggleDarkTheme() {
        self.darkTheme = !self.darkTheme
    }
    
    var colorScheme: ColorScheme {
        self.darkTheme ? .dark : .light
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
