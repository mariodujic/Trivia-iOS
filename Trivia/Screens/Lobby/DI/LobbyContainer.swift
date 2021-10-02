import Swinject
import Foundation

extension Container {
    
    static let lobbyContainer: Container = {
        let container = Container()
        container.register(LobbyViewModel.self, factory: {_ in LobbyViewModel()})
        return container
    }()
}
