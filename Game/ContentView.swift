//
//  ContentView.swift
//  Game
//
//  Created by M1 Mac 1 on 1/27/22.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password:password){[weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
}


struct ContentView: View {
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        NavigationView {
           
                if  viewModel.signedIn {
                    VStack {
                        Text("You are signed in")
                        Button(action: {
                            viewModel.signOut()
                        }, label: {
                            Text("Sign Out").foregroundColor(Color.blue)})
                    }
                }
                else {
                    SignInView()
                }
        }.onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView : View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel : AppViewModel
    
    var body : some View {
        VStack {
            Spacer()
            VStack{
                Text("UNI GAME").font(.system(size: 30, weight: .heavy, design: .default))
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                Button(action:{
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                }, label: {
                    Text("Login").foregroundColor(Color.white).frame(width: 200, height: 50).background(Color.black)
                }).cornerRadius(8).padding()
                
                NavigationLink("Create Account", destination: SignUpView()).padding()
                
            }.padding()
            Spacer()
            
        }
    }
}


struct SignUpView : View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel : AppViewModel
    
    var body : some View {
        VStack {
            Spacer()
            VStack{
                Text("UNI GAME").font(.system(size: 30, weight: .heavy, design: .default))
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                Button(action:{
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                }, label: {
                    Text("Create Account").foregroundColor(Color.white).frame(width: 200, height: 50).background(Color.black)
                }).cornerRadius(8).padding()
                
            }.padding()
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
