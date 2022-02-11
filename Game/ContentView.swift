//
//  ContentView.swift
//  Game
//
//  Created by M1 Mac 1 on 1/27/22.
//

import SwiftUI
import FirebaseAuth
import Firebase
import UIKit


struct ContentView: View {
    @EnvironmentObject var viewModel : AppViewModel
    let userViewModel = UserViewModel()
    var body: some View {
        NavigationView {
            if  viewModel.signedIn {
                TabBar().environmentObject(userViewModel)
            }
            else {
                SignInView()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
           
        }
    }
}


struct TabBar : View {
    @EnvironmentObject var usersViewModel : UserViewModel
    init() {
        UITabBar.appearance().backgroundColor = UIColor.tertiarySystemFill
    }
    var body : some View {
        TabView {
            NavigationView{
                HomeView()
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            NavigationView{
                UsersListView()
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "person.3")
                Text("Users")
            }
            NavigationView{
                AccountView()
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Account")
            }
            
        }
        .accentColor(.black)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear() {
            usersViewModel.fetchUsers()
            UITabBar.appearance().barTintColor = .black
            
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


