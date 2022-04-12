//
//  HomeView.swift
//
//  Created by Amer on 10.03.22.
//
//Home page UI

import SwiftUI

struct HomeView: View {
    
    @State var selection: Int? = nil
    var body: some View {
            //List of games UI
            VStack(alignment: .leading, spacing: 8){
                Text("Games").font(.largeTitle).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                
                NavigationView {
                  List{
                      //Tic-Tac-Toe game play opition
                      ZStack(alignment: .bottom) {
                        Image("tic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .cornerRadius(20)
                        HStack(alignment: .center, spacing:5){
                            Text("Tik Tak Toe").foregroundColor(.white).font(.system(size: 15, weight: .heavy, design: .default)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                           
                            NavigationLink(destination: TypeOfGameOptionView(), tag: 1, selection: $selection) {
                                Button(action: {
                                    self.selection = 1
                                }){
                                    Text("Play")
                                        .font(.system(size: 12, weight: .heavy, design: .default))
                                        .foregroundColor(Color.black).frame(width: 100, height: 30).background(Color.white).cornerRadius(30)
                                }}
                        }.padding()
                              .frame(alignment: .trailing)
                    }
                      //Mental Calculation game play opition
                    ZStack(alignment: .bottom) {
                        Image("mat")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .cornerRadius(20)
                        HStack(alignment: .center, spacing:5){
                            Text("Mental Calculation").foregroundColor(.black).font(.system(size: 15, weight: .heavy, design: .default)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                            
                            NavigationLink(destination: MentalCalculationView(), tag: 2, selection: $selection) {
                                Button(action: {
                                    self.selection = 2
                                }){
                                    Text("Play")
                                        .font(.system(size: 12, weight: .heavy, design: .default))
                                        .foregroundColor(Color.black).frame(width: 100, height: 30).background(Color.white).cornerRadius(30)
                                }}
                        }.padding()
                    }
                      //Activity Challenge game play opition
                    ZStack(alignment: .bottom) {
                        Image("steps")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .cornerRadius(20)
                        HStack(alignment: .center, spacing:5){
                            Text("Activity Challenge").foregroundColor(.white).font(.system(size: 15, weight: .heavy, design: .default)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                            
                            NavigationLink(destination: ActivityChallengeView(), tag: 3, selection: $selection) {
                                Button(action: {
                                    self.selection = 3
                                }){
                                    Text("Play")
                                        .font(.system(size: 12, weight: .heavy, design: .default))
                                        .foregroundColor(Color.black).frame(width: 100, height: 30).background(Color.white).cornerRadius(30)
                                }}
                        }.padding()
                    }
                      //Compass game play opition
                      ZStack(alignment: .bottom) {
                          Image("comp")
                              .resizable()
                              .aspectRatio(contentMode: .fill)
                              .frame(height: 200)
                              .cornerRadius(20)
                          HStack(alignment: .center, spacing:5){
                              Text("Compass Game").foregroundColor(.white).font(.system(size: 15, weight: .heavy, design: .default)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                              
                              NavigationLink(destination: CompassGame(), tag: 4, selection: $selection) {
                                  Button(action: {
                                      self.selection = 4
                                  }){
                                      Text("Play")
                                          .font(.system(size: 12, weight: .heavy, design: .default))
                                          .foregroundColor(Color.black).frame(width: 100, height: 30).background(Color.white).cornerRadius(30)
                                  }} .frame(width:100,alignment: .trailing)
                          }.padding()
                      }
                  } .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
             
            }.padding(.horizontal)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
struct MyView: View {
    let number: String
    
    var body: some View {
        Text(number)
    }
}

