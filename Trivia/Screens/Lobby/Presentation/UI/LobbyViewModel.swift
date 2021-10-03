import Foundation

class LobbyViewModel: ObservableObject {
    
    @Published var lobbyState: LobbyState = .GenerateQuiz
    @Published var questionNumber: Int = 10
    
    var validQuestionNumber: Bool  {
        questionNumber != 0
    }
}
