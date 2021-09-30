import Swinject
import Foundation

extension Container {
    
    static let quizContainer: Container = {
        let container = Container()
        
        container.register(HttpClient.self, factory: {_ in HttpClient()})
        container.register(QuizAPI.self, factory: {r in
            QuizAPI(client: r.resolve(HttpClient.self)!)
        })
        container.register(QuizQuestionsUiMapper.self, factory: {_ in QuizQuestionsUiMapper()})
        container.register(QuizViewModel.self, factory: {r in
            QuizViewModel(
                triviaApi: r.resolve(QuizAPI.self)!,
                triviaUiMapper: r.resolve(QuizQuestionsUiMapper.self)!
            )
        })
        return container
    }()
}
