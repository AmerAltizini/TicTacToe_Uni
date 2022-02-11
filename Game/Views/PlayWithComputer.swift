//
//  PlayWithComputer.swift
//  Game
//
//  Created by M1 Mac 1 on 2/6/22.
//

import Foundation
import SwiftUI

enum SquareStatus {
    case empty
    case home
    case visitor
}

class Square : ObservableObject {
    @Published var squareStatus : SquareStatus
    
    init(status : SquareStatus) {
        self.squareStatus = status
    }
}

struct SquareView : View {
    @ObservedObject var dataSource : Square
    var action: () -> Void
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(self.dataSource.squareStatus == .home ?
                 "X" : self.dataSource.squareStatus == .visitor ? "0" : " ")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .frame(width: 70, height: 70, alignment: .center)
                .background(Color.gray.opacity(0.3).cornerRadius(10))
                .padding(4)
        })
    }
}


struct PlayWithComputer: View {
    @StateObject var ticTacToeModel = TicTacToeModel()
    @State var gameOver : Bool = false
    
    func buttonAction(_ index : Int) {
        _ = self.ticTacToeModel.makeMove(index: index, player: .home)
        self.gameOver = self.ticTacToeModel.gameOver.1
    }
    
    var body: some View {
        VStack {
            ForEach(0 ..< ticTacToeModel.squares.count / 3, content: {
                row in
                HStack {
                    ForEach(0 ..< 3, content: {
                        column in
                        let index = row * 3 + column
                        SquareView(dataSource: ticTacToeModel.squares[index], action: {self.buttonAction(index)})
                    })
                }
            })
        }.alert(isPresented: self.$gameOver, content: {
            Alert(title: Text("Game Over"),
                  message: Text(self.ticTacToeModel.gameOver.0 != .empty ? self.ticTacToeModel.gameOver.0 == .home ? "You Win!": "AI Wins!" : "Nobody Wins" ) , dismissButton: Alert.Button.destructive(Text("Ok"), action: {
                self.ticTacToeModel.resetGame()
            }))
        })
    }
}

struct PlayWithComputer_Previews: PreviewProvider {
    static var previews: some View {
        PlayWithComputer()
    }
}
