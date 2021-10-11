import SwiftUI
import Swinject

struct LobbyView: View {
    
    @ObservedObject private var lobbyViewModel: LobbyViewModel = Container.lobbyContainer.resolve(LobbyViewModel.self)!
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    LottieView(filename: "lottie-background", loop: true)
                        .frame(height: 500)
                        .scaleEffect(1.3)
                        .offset(y: 150)
                }
                VStack(spacing: 20) {
                    LottieView(filename: "lottie-quiz-logo").frame(height: 300)
                    if lobbyViewModel.lobbyState == .generateQuiz ||
                        lobbyViewModel.lobbyState == .errorGeneratingQuiz {
                        Text(Strings.lobbyNumberOfQuizQuestions).font(.system(size: 25, weight: .bold))
                        Picker("", selection: $lobbyViewModel.questionNumber, content: {
                            Text(Strings.lobbyQuestionNumberTen).tag(10)
                            Text(Strings.lobbyQuestionNumberTwentyFive).tag(25)
                            Text(Strings.lobbyQuestionNumberFifty).tag(50)
                        })
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 250)
                        if lobbyViewModel.lobbyState == .errorGeneratingQuiz {
                            Text(Strings.lobbyErrorGeneratingQuiz)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.red)
                        }
                        Button(Strings.lobbyGenerateQuiz) {
                            lobbyViewModel.lobbyState = .retrivingQuiz
                            lobbyViewModel.generateQuiz(numberOfQuestions: lobbyViewModel.questionNumber)
                        }
                        .padding(10)
                        .frame(width: 210)
                        .font(.system(size: 25))
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .disabled(!lobbyViewModel.validQuestionNumber)
                    } else if lobbyViewModel.lobbyState == .retrivingQuiz {
                        LottieView(filename: "lottie-quiz-generation", loop: true).frame(height: 200)
                    }else if lobbyViewModel.lobbyState == .playQuiz {
                        NavigationLink(Strings.lobbyPlayQuiz, destination: QuizView(triviaQuestions: lobbyViewModel.triviaQuestions!))
                            .padding(10)
                            .font(.system(size: 25))
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                }
                HStack(alignment: .top) {
                    Spacer()
                    Button(action: {
                        self.lobbyViewModel.toggleDarkTheme()
                    }) {
                        Image(uiImage: UIImage(named: lobbyViewModel.darkTheme ? "turned-on" : "turned-off")!)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )
                .padding(8)
            }
            .background(lobbyViewModel.darkTheme ? Colors.darkColor : Color.white)
            .preferredColorScheme(lobbyViewModel.colorScheme)
            .navigationBarHidden(true)
            .onAppear{
                self.lobbyViewModel.lobbyState = .generateQuiz
            }
        }
        .accentColor( .black)
    }
}
