
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


