import Foundation
import SwiftUI

struct ResultView: View {
    
    private var quizResult: String
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    init(quizResult: String){
        self.quizResult = quizResult
    }
    
    var body: some View {
        VStack(spacing: 15){
            Text("Correct answers:")
            Text(self.quizResult)
                .font(.system(size: 26, weight: .bold))
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        )
        .navigationBarHidden(true)
        .background(colorScheme != .dark ? Color.white : darkColor)
    }
}
