@testable import Trivia

let fakeQuestions = [
    TriviaQuestion(
        category: "a",
        type: TypeEnum.boolean,
        difficulty: .easy,
        question: "b",
        correctAnswer: "c",
        incorrectAnswers: ["d","e"]
    ),
    TriviaQuestion(
        category: "f",
        type: TypeEnum.boolean,
        difficulty: .easy,
        question: "g",
        correctAnswer: "h",
        incorrectAnswers: ["i","j"]
    )
]
