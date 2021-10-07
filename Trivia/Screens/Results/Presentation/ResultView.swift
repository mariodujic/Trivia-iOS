import Foundation
import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject var quizViewModel: QuizViewModel

    var body: some View {
        VStack(spacing: 15){
            Text("Correct answers:")
            Text(quizViewModel.getResults())
                .font(.system(size: 26, weight: .bold))
        }
    }
}
