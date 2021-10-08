import SwiftUI
import Swinject

struct LobbyView: View {
    
    @ObservedObject private var lobbyViewModel: LobbyViewModel = Container.lobbyContainer.resolve(LobbyViewModel.self)!
    @State private var colorScheme: ColorScheme? = nil
    
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
                        Text("Number of quiz questions").font(.system(size: 25, weight: .bold))
                        Picker("", selection: $lobbyViewModel.questionNumber, content: {
                            Text("10").tag(10)
                            Text("25").tag(25)
                            Text("50").tag(50)
                        })
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 250)
                        if lobbyViewModel.lobbyState == .errorGeneratingQuiz {
                            Text("Error generating quiz, check your connection\nand try again.")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.red)
                        }
                        Button("Generate Quiz") {
                            lobbyViewModel.lobbyState = .retrivingQuiz
                            lobbyViewModel.generateQuiz(numberOfQuestions: lobbyViewModel.questionNumber) { success in
                                if(success) {
                                    lobbyViewModel.lobbyState = .playQuiz
                                } else {
                                    lobbyViewModel.lobbyState = .errorGeneratingQuiz
                                }
                            }
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
                        NavigationLink("Play Quiz", destination: QuizView(triviaQuestions: lobbyViewModel.triviaQuestions!))
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
                        colorScheme = colorScheme != .dark ? .dark : .light
                    }) {
                        Image(uiImage: UIImage(named: colorScheme != .dark ? "turned-off" : "turned-on")!)
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
            .background(colorScheme != .dark ? Color.white : darkColor)
            .preferredColorScheme(colorScheme)
            .navigationBarHidden(true)
        }.accentColor( .black)
    }
}
