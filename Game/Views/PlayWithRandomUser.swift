//
//  PlayWithRandomUser.swift
//  Game
//
//  Created by M1 Mac 1 on 2/6/22.
//

import SwiftUI

struct PlayWithRandomUser: View {
    @ObservedObject var viewModel:  MultiPlayerViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Waiting for another player")
                NavigationLink(destination: HomeView()) {
                    Button {
                        //                    print("qiuit")
                        // navigate back
                        viewModel.quiteGame()
                    } label: {
                        Text("Quit")
                    }}
                LoadingView()
                Spacer()
                
                VStack {
                    LazyVGrid(columns: viewModel.columns, spacing: 5){
                        ForEach(0..<9) {
                            i in
                            ZStack {
                                GameSquareView(proxy: geometry)
                                PlayerIndicatorView(systemImageName: viewModel.game?.moves[i]?.indicator ?? "applelogo")
                            }.onTapGesture {
                                viewModel.processPlayerMove(for: i)
                                
                            }
                        }
                    }
                }.disabled(viewModel.checkForGameBoardStatus())
            }
        }.onAppear {
            viewModel.getTheGame()
        }
    }
}

struct GameSquareView: View {
    var proxy: GeometryProxy
    var body: some View {
        Circle()
            .foregroundColor(.blue.opacity(0.7))
            .frame(width: proxy.size.width / 3 - 15, height: proxy.size.width / 3 - 15)
    }
}

struct PlayerIndicatorView: View {
    var systemImageName: String
    var body : some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
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
        }
    }
}

struct PlayWithRandomUser_Previews: PreviewProvider {
    static var previews: some View {
        PlayWithRandomUser(viewModel: MultiPlayerViewModel())
    }
}
