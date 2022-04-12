import SwiftUI
// play with random user tictactoe UI
struct PlayWithRandomUser: View {
    @ObservedObject var viewModel:  MultiPlayerViewModel
    @Binding var showModalWithRandomUser: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.quiteGame()
                        self.showModalWithRandomUser.toggle()
                    }){
                        Image(systemName:"xmark.circle").resizable().frame(width: 30, height: 30)
                    }
                }
                if viewModel.game?.player2Id == "" {
                    LoadingView()
                }
                
                Text(viewModel.gameNotification).font(.system(size: 15, weight: .medium, design: .default)).padding()
                    .frame(minWidth: 200, maxWidth: .infinity, alignment: .center)
                
                
                
                HStack {
                    LazyVGrid(columns: viewModel.columns, alignment: .leading, spacing: 15){
                        ForEach(0..<9) {
                            i in
                            ZStack {
                                GameSquareView()
                                PlayerIndicatorView(systemImageName: viewModel.game?.moves[i]?.indicator ?? "applelogo")
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: i)
                            }
                        }
                    }
                }
                .padding(.horizontal,30)
                .disabled(viewModel.checkForGameBoardStatus())
                .padding()
                .alert(item: $viewModel.alertItem) {
                    alertItem in
                    alertItem.isForQuit ? Alert(title: alertItem.title, message: alertItem.message, dismissButton: .destructive(alertItem.buttonTitle, action: {
                        self.showModalWithRandomUser.toggle()
                        viewModel.quiteGame()
                    }))
                    : Alert(title: alertItem.title, message: alertItem.message, primaryButton: .default(alertItem.buttonTitle, action: {
                        viewModel.resetGame()
                    }), secondaryButton: .destructive(Text("Quit"), action: {
                        self.showModalWithRandomUser.toggle()
                        viewModel.quiteGame()
                    }))
                }
            }
        }.onAppear {
            viewModel.getTheGame()
        }.padding()
    }
}

struct GameSquareView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 70, height: 70, alignment: .center)
    }
}

struct PlayerIndicatorView: View {
    var systemImageName: String
    var body : some View {
        Image(systemName: systemImageName)
            .foregroundColor(.black)
            .frame(width: 70, height: 70, alignment: .center)
            .opacity(systemImageName == "applelogo" ? 0 : 1 )
    }
}

struct LoadingView : View {
    var body : some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
        }.frame(width: .infinity, height: 100, alignment: .center)
    }
}


