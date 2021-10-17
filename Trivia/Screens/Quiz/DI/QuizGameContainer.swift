import Swinject

extension Container {
    
    static func quizContainer(questions: [TriviaQuestion]) -> Container {
        let container = Container()
        container.register(QuizQuestionsNetworkToUiMapper.self, factory: {_ in QuizQuestionsNetworkToUiMapper()})
        container.register(QuizViewModel.self, factory: {r in
            QuizViewModel(
                quizQuestionsUiMapper: r.resolve(QuizQuestionsNetworkToUiMapper.self)!,
                triviaQuestions: questions
            )
        })
        return container
    }
}
