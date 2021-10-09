import SwiftUI
import Swinject
import Foundation

struct QuizView: View {
    
    private var triviaQuestions: [TriviaQuestion]
    @StateObject private var quizViewModel: QuizViewModel
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    init(triviaQuestions: [TriviaQuestion]) {
        self.triviaQuestions = triviaQuestions
        _quizViewModel = StateObject(wrappedValue: Container.quizContainer(questions: triviaQuestions).resolve(QuizViewModel.self)!)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                LottieView(filename: "lottie-background", loop: true)
                    .frame(height: 500)
                    .scaleEffect(1.3)
                    .offset(y: 150)
            }
            VStack {
                ZStack {
                    ZStack {
                        Text(quizViewModel.currentQuestionIndicator).font(.system(size: 25))
                    }
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                    }
                }
                VStack{
                    Spacer()
                    Text(quizViewModel.currentQuestion).font(.system(size: 22))
                    ForEach(quizViewModel.answers, id: \.hashValue) {answer in
                        Button(action: {
                            quizViewModel.setSelectedAnswer(selectedAnswer: answer)
                        }){
                            HStack{
                                Image(systemName: quizViewModel.selectedAnswer == answer ? "checkmark.square" : "square")
                                    .font(.system(size: 22))
                                Text(answer)
                                    .font(.system(size: 19))
                            }.foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    }
                    .padding(.leading)
                    Spacer()
                }
                if quizViewModel.hasMoreQuestions {
                    Button(action: {
                        quizViewModel.onNextQuestion()
                    }) {
                        HStack {
                            Image(systemName: "play")
                                .font(.system(size: 25))
                            Text(Strings.quizNextQuestion)
                                .fontWeight(.semibold)
                                .font(.system(size: 15))
                        }
                        .padding(.init(top: 12, leading: 15, bottom: 12, trailing: 15))
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(40)
                    }
                    .disabled(!quizViewModel.hasSelectedAnswer)
                } else {
                    NavigationLink(
                        Strings.quizFinishQuiz,
                        destination: ResultView(quizResult: quizViewModel.getResults())
                    )
                        .padding(.init(top: 12, leading: 15, bottom: 12, trailing: 15))
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(40)
                        .disabled(!quizViewModel.hasSelectedAnswer)
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
        .background(colorScheme != .dark ? Color.white : Colors.darkColor)
        
    }
}
