//
//  ContentView.swift
//  Game
//
//  Created by M1 Mac 1 on 1/27/22.
//

import SwiftUI

struct ContentView: View {
    @State var email = ""
    @State var password=""
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack{
                    Text("Uni Game").font(.system(size: 30, weight: .heavy, design: .default))
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    Button(action:{
                
                    }, label: {
                        Text("Login").foregroundColor(Color.white).frame(width: 200, height: 50).background(Color.black)
                    }).cornerRadius(8).padding()
                    
                }.padding()
                Spacer()
                
            }.navigationTitle("")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
