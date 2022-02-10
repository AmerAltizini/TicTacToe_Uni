//
//  MultiPlayerViewModel.swift
//  Game
//
//  Created by M1 Mac 1 on 2/6/22.
//

import SwiftUI

final class MultiPlayerViewModel: ObservableObject {

    @AppStorage("users") private var userData: Data?
    
    let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    @Published var game = Game(id: UUID().uuidString, player1Id: "player1", player2Id: "player2", blockMoveForPlayerId: "player2", winningPlayerId: "", rematchPlayerId: [], moves: Array(repeating: nil, count: 9))
    
//    @Published var current
    
    //condition that dictate game winning
    private let winPatterns: Set<Set<Int>> = [ [0, 1, 2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6] ]
    
    
    init(){
        
    }
    
    func processPlayerMove(for position: Int) {
        //check if the position is occupied
        
        if isSquareOccupied(in: game.moves, forIndex: position) { return }
        
        game.moves[position] = Move(isPlayer1: true, boardIndex: position)
        game.blockMoveForPlayerId = "player2"
        
        //block the move
        
        if checkForWinCondition(for: true, in: game.moves){
            print("You have won")
            return
        }
        //check for draw
        if checkForDraw(in: game.moves){
            print("Draw")
            return
        }
        //chek the win
      
        
    }
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func checkForWinCondition(for player1: Bool, in moves: [Move?]) -> Bool {
        let playerMoves = moves.compactMap { $0 }.filter{ $0.isPlayer1 == player1 }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
}

