import Swinject
import Foundation

extension Container {
    
    static let lobbyContainer: Container = {
        let container = Container()
        container.register(HttpClient.self, factory: {_ in HttpClient()})
        container.register(LobbyApi.self, factory: {r in
            LobbyApiImpl(client: r.resolve(HttpClient.self)!)
        })
        container.register(LobbyViewModel.self, factory: {r in
            LobbyViewModel(triviaApi: r.resolve(LobbyApi.self)!)
        })
        return container
    }()
}
