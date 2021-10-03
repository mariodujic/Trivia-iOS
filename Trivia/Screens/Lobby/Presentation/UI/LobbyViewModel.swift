import Foundation

class LobbyViewModel: ObservableObject {
    
    @Published var lobbyState: LobbyState = .GenerateQuiz
    @Published var questionNumber: String = ""
    
    var validQuestionNumber: Bool  {
        questionNumber.isDigits && !questionNumber.isEmpty
    }
}
