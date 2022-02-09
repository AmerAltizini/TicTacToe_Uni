//
//  SignInView.swift
//  Game
//
//  Created by M1 Mac 1 on 1/30/22.
//

import SwiftUI

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
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                }) {
                    Text(viewModel.signInLoading ? "Loading...":"Login").foregroundColor(Color.white).frame(width: 200, height: 50).background(Color.black)
                }
                .alert(isPresented: $viewModel.showAlert, content: { () -> Alert in
                    Alert(title: Text("Sign in Error"), message: Text(viewModel.authError), dismissButton: .default(Text("Okay")))
                }).cornerRadius(8).padding()
                
                NavigationLink( "Create Account", destination: SignUpView()).padding()
                
            }.padding()
            Spacer()
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
