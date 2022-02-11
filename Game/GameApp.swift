//
//  GameApp.swift
//  Game
//
//  Created by M1 Mac 1 on 1/27/22.
//

import SwiftUI
import Firebase

@main
struct GameApp: App {
    init() {
          FirebaseApp.configure()
      }
  
  var body: some Scene {
      let  viewModel = AppViewModel()
     
      WindowGroup {
        ContentView().environmentObject(viewModel)
    }
  }
}


