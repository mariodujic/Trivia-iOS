class QuizQuestionsUiMapper {
    
    func map(questions: [TriviaQuestion]) -> [TriviaQuestion] {
        questions.map {question in
            TriviaQuestion(
                category: question.category,
                difficulty:question.difficulty,
                question: question.question.htmlToString,
                correctAnswer: question.correctAnswer.htmlToString,
                incorrectAnswers: question.incorrectAnswers.map{answer in
                    answer.htmlToString
                })
        }
    }
}
