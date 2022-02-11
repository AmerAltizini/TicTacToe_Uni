//
//  TypeOfGameOptionView.swift
//  Game
//
//  Created by M1 Mac 1 on 2/5/22.
//

import SwiftUI

struct TypeOfGameOptionView: View {
    
    @StateObject var viewModel = MultiPlayerViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Choose game type").font(.title3).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
            NavigationLink(destination: PlayWithComputer()) {
                CardView(card: Card.option1  )
            }
            NavigationLink(destination: PlayWithRandomUser(viewModel: MultiPlayerViewModel())) {
                CardView(card: Card.option2)
                
            }
            NavigationLink(destination: PlayWithFriends()) {
                CardView(card: Card.option3)
            }
        } .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        
    }
}

struct CardView: View {
    let card: Card
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 5)
            VStack {
                Text(card.title)
                    .padding()
                    .foregroundColor(.black)
            }
        }.frame(height: 70)
    }
}


struct TypeOfGameOptionView_Previews: PreviewProvider {
    static var previews: some View {
        TypeOfGameOptionView()
    }
}
