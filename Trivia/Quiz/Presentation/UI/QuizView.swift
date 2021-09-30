import SwiftUI
import Swinject
import Foundation

struct QuizView: View {
    
    @ObservedObject var viewModel: QuizViewModel = Container.quizContainer.resolve(QuizViewModel.self)!
    
    var body: some View {
        switch viewModel.state {
        case State.Loading:
            LottieView(filename: "lottie-loading")
        case State.Error:
            LottieView(filename: "lottie-error")
        case State.Success:
            ZStack(alignment: .bottom) {
                VStack {
                    Spacer().background(Color.red)
                    LottieView(filename: "lottie-background")
                        .frame(height: 500)
                        .scaleEffect(1.3)
                        .offset(y: 150)
                }
                VStack {
                    Text(viewModel.currentQuestionIndicator).font(.system(size: 25))
                    VStack{
                        Spacer()
                        Text(viewModel.currentQuestion).font(.system(size: 22))
                        ForEach(viewModel.answers, id: \.hashValue) {answer in
                            Button(action: {
                                viewModel.setSelectedAnswer(selectedAnswer: answer)
                            }){
                                HStack{
                                    Image(systemName: viewModel.selectedAnswer == answer ? "checkmark.square" : "square")
                                        .font(.system(size: 22))
                                    Text(answer)
                                        .font(.system(size: 19))
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top)
                        }
                        .padding(.leading)
                        .foregroundColor(Color.black)
                        Spacer()
                    }
                    if viewModel.hasMoreQuestions {
                        Button(action: {
                            viewModel.onNextQuestion()
                        }) {
                            HStack {
                                Image(systemName: "play")
                                    .font(.system(size: 25))
                                Text("Next Question")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 15))
                            }
                            .padding(.init(top: 12, leading: 15, bottom: 12, trailing: 15))
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(40)
                        }
                        .disabled(!viewModel.hasSelectedAnswer)
                    }
                }.padding()
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            QuizView()
        }
    }
}
