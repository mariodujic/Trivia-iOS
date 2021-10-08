import Swinject

extension Container {
    
    static func quizContainer(questions: [TriviaQuestion]) -> Container {
        let container = Container()
        container.register(QuizQuestionsUiMapper.self, factory: {_ in QuizQuestionsUiMapper()})
        container.register(QuizViewModel.self, factory: {r in
            QuizViewModel(
                quizQuestionsUiMapper: r.resolve(QuizQuestionsUiMapper.self)!,
                triviaQuestions: questions
            )
        })
        return container
    }
}
