import Swinject

extension Container {
    
    static func resultContainer(quizResult: QuizResult) -> Container {
        let container = Container()
        container.register(ResultViewModel.self, factory: {r in
            ResultViewModel(quizResult: quizResult)
        })
        return container
    }
}
