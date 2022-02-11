//
//  Notification.swift
//  Game
//
//  Created by M1 Mac 1 on 2/10/22.
//

import SwiftUI

enum GameState {
    case started
    case waitingForPLayer
    case finished
}

struct GameNotification {
    static let waitingForPlayer = "Waiting for player"
    static let gameHasStarted = "Game has started"
    static let gameFinished = "Player left the game"
}
