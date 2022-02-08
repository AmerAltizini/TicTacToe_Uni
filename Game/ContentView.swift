//
//  ContentView.swift
//  Game
//
//  Created by M1 Mac 1 on 1/27/22.
//

import SwiftUI
import FirebaseAuth
import Firebase

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var signInLoading = false
    
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    func signIn(email: String, password: String){
        self.signInLoading = true
        auth.signIn(withEmail: email, password:password){[weak self] result, error in
            guard result != nil, error == nil else {
                self?.signInLoading = false
                return
            }
            DispatchQueue.main.async {
                self?.signInLoading = false
                self?.signedIn = true
            }
        }
    }
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }
    func signUp(email: String, password: String, firstName: String, lastName: String){
        self.signInLoading = true
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else {
                self?.signInLoading = false
                print("Error writing document auth: \(error)")
                return
            }
           
            let db = Firestore.firestore()
            
            db.collection("users").document(result!.user.uid).setData([
                "firstName": firstName,
                "lastName": lastName,
                "uid": result!.user.uid
            ]) { err in
                if let err = err {
                    self?.signInLoading = false
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self?.signInLoading = false
                    DispatchQueue.main.async {
                        self?.signedIn = true
                    }
                }
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
            
            VStack{
                Image(systemName: "greetingcard").resizable().frame(width: 60, height: 60)
                Text("UNI GAME").font(.system(size: 35, weight: .heavy, design: .default))
                
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
                    Text("Login").foregroundColor(Color.white).frame(width: 200, height: 50).background(Color.black)
                }).cornerRadius(8).padding()
                
                NavigationLink( "Create Account", destination: SignUpView()).padding()
                
            }.padding()
            Spacer()
            
        }
    }
}


struct SignUpView : View {
    @State var email = ""
    @State var password = ""
    @State var firstName = ""
    @State var lastName = ""
    
    @EnvironmentObject var viewModel : AppViewModel
    
    var body : some View {
        VStack {
            VStack{
                Image(systemName: "greetingcard").resizable().frame(width: 60, height: 60)
                Text("UNI GAME").font(.system(size: 35, weight: .heavy, design: .default))
                
                TextField("First Name", text: $firstName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                   
                TextField("Last Name", text: $lastName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.top)
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.top)
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                Button(action:{
                    guard  !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password, firstName: firstName, lastName: lastName)
                   
                }, label: {
                    Text(viewModel.signInLoading ? "Loading...":"Create Account" ).foregroundColor(Color.white).frame(width: 200, height: 50).background(Color.black)
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
