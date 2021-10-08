import Foundation
import SwiftUI

struct ResultView: View {
    
    private var quizResult: String
    
    init(quizResult: String){
        self.quizResult = quizResult
    }

    var body: some View {
        VStack(spacing: 15){
            Text("Correct answers:")
            Text(self.quizResult)
                .font(.system(size: 26, weight: .bold))
        }
    }
}
