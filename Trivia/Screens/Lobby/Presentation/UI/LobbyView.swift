import SwiftUI
import Swinject

struct LobbyView: View {
    
    @StateObject var quizViewModel: QuizViewModel = Container.quizContainer.resolve(QuizViewModel.self)!
    @ObservedObject var lobbyViewModel: LobbyViewModel = Container.lobbyContainer.resolve(LobbyViewModel.self)!
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer().background(Color.red)
                    LottieView(filename: "lottie-background", loop: true)
                        .frame(height: 500)
                        .scaleEffect(1.3)
                        .offset(y: 150)
                }
                VStack {
                    LottieView(filename: "lottie-quiz-logo").frame(height: 300)
                    if lobbyViewModel.lobbyState == .GenerateQuiz {
                        Button("Generate Quiz") {
                            lobbyViewModel.lobbyState = .RetrivingQuiz
                            quizViewModel.generateQuiz { success in
                                if(success) {
                                    lobbyViewModel.lobbyState = .PlayQuiz
                                } else {
                                    lobbyViewModel.lobbyState = .GenerateQuiz
                                }
                            }
                        }
                        .padding(10)
                        .font(.system(size: 25))
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding(.top, 200)
                    } else if lobbyViewModel.lobbyState == .RetrivingQuiz {
                        LottieView(filename: "lottie-quiz-generation").frame(height: 200)
                    }else if lobbyViewModel.lobbyState == .PlayQuiz {
                        NavigationLink("Play Quiz", destination: QuizView().environmentObject(quizViewModel))
                            .padding(10)
                            .font(.system(size: 25))
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .padding(.top, 200)
                    }
                }
            }.navigationBarHidden(true)
        }.accentColor( .black)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            LobbyView()
        }
    }
}
