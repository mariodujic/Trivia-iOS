import Foundation
import Combine
import SwiftUI

final class LobbyViewModel: ObservableObject {
    
    @Published var lobbyState: LobbyState = .generateQuiz
    @Published var questionNumber: Int = 10
    @Published private (set) var triviaQuestions: [TriviaQuestion]? = nil
    
    let darkThemeKey: String = "darkThemeKey"
    
    private var cancellable: AnyCancellable? = nil
    private var triviaApi: LobbyAPIProviding
    private var storageService: StorageService
    
    @Published private(set) var darkTheme: Bool! {
        didSet { storageService.setBool(key: darkThemeKey, value: darkTheme) }
    }
    
    init(triviaApi: LobbyAPIProviding, storageService: StorageService){
        self.triviaApi = triviaApi
        self.storageService = storageService
        self.getDarkTheme()
    }
    
    private func getDarkTheme() {
        self.darkTheme = self.storageService.getBool(key: darkThemeKey)
    }
    
    func toggleDarkTheme() {
        self.darkTheme.toggle()
    }
    
    var colorScheme: ColorScheme {
        self.darkTheme ? .dark : .light
    }
    
    var validQuestionNumber: Bool  {
        questionNumber != 0
    }
    
    func generateQuiz(numberOfQuestions: Int) {
        self.cancellable = self.triviaApi.fetchQuiz(amount: numberOfQuestions)
            .sink( receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure:
                    self?.lobbyState = .errorGeneratingQuiz
                case .finished:
                    print("Success")
                }
                self?.cancellable?.cancel()
            }, receiveValue: { value in
                self.triviaQuestions = value.results
                if self.triviaQuestions != nil && self.triviaQuestions!.count != 0 {
                    self.lobbyState = .playQuiz
                }else {
                    self.lobbyState = .errorGeneratingQuiz
                }
            })
    }
}
