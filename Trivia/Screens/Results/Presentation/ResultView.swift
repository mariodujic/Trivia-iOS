import Foundation
import SwiftUI
import Swinject

struct ResultView: View {
    
    @StateObject private var resultViewModel: ResultViewModel
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    init(quizResult: QuizResult){
        _resultViewModel = StateObject(wrappedValue: Container.resultContainer(quizResult:quizResult).resolve(ResultViewModel.self)!)
    }
    
    var body: some View {
        VStack(spacing: 15){
            Text(Strings.resultCorrectAnswers)
            Text(self.resultViewModel.quizResult.result).font(.system(size: 26, weight: .bold))
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        )
        .navigationBarHidden(true)
        .background(colorScheme != .dark ? Color.white : Colors.darkColor)
    }
}
