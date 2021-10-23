import Swinject
import Foundation

extension Container {
    
    static let lobbyContainer: Container = {
        let container = Container()
        container.register(HttpClient.self, factory: {_ in HttpClient()})
        container.register(StorageService.self, factory: {_ in StorageService()})
        container.register(LobbyAPIProviding.self, factory: {r in
            LobbyAPI(client: r.resolve(HttpClient.self)!)
        })
        container.register(LobbyViewModel.self, factory: {r in
            LobbyViewModel(
                triviaApi: r.resolve(LobbyAPIProviding.self)!,
                storageService: r.resolve(StorageService.self)!
            )
        })
        return container
    }()
}
