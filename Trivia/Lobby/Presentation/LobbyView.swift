import SwiftUI

struct LobbyView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer().background(Color.red)
                    LottieView(filename: "lottie-background")
                        .frame(height: 500)
                        .scaleEffect(1.3)
                        .offset(y: 150)
                }
                VStack {
                    LottieView(filename: "lottie-quiz-logo")
                        .frame(height: 300)
                    NavigationLink("StartGame", destination: QuizView())
                        .padding(10)
                        .font(.system(size: 25))
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding(.top, 200)
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
