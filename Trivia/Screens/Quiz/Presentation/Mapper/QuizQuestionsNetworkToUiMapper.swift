final class QuizQuestionsNetworkToUiMapper {
    
    func map(questions: [TriviaQuestion]) -> [TriviaQuestionUi] {
        questions.map {question in
            var allAnswers = question.incorrectAnswers
            allAnswers.append(question.correctAnswer)
            return TriviaQuestionUi(
                question: question.question.htmlToString,
                correctAnswer: question.correctAnswer.htmlToString,
                allAnswers: allAnswers
                    .map{answer in answer.htmlToString}
                    .shuffled()
            )
        }
    }
}
