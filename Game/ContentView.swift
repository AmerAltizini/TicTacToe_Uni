//
//  ContentView.swift
//  Game
//
//  Created by M1 Mac 1 on 1/27/22.
//

import SwiftUI
import FirebaseAuth
import Firebase


struct ContentView: View {
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        NavigationView {
            
            if  viewModel.signedIn {
                TabView {
                    HomeView().tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    UsersListView().tabItem {
                        Image(systemName: "person.3")
                        Text("Users")
                    }
                    AccountView().tabItem {
                        Image(systemName: "person")
                        Text("Account")
                    }
                }
                .onAppear() {
                        UITabBar.appearance().barTintColor = .white
                }
                .accentColor(.black)
            }
            else {
                SignInView()
            }
        }.onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
