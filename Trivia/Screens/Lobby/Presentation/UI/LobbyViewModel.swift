import Foundation

class LobbyViewModel: ObservableObject {
    
    @Published var lobbyState: LobbyState = .GenerateQuiz
}
