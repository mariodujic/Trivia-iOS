import Foundation

struct QuizResponse: Codable {
    let responseCode: Int
    let results: [TriviaQuestion]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

struct TriviaQuestion: Codable, Equatable {
    let category: String
    let difficulty: Difficulty
    let question, correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case category, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

enum Difficulty: String, Codable {
    case easy = "easy"
    case hard = "hard"
    case medium = "medium"
}
