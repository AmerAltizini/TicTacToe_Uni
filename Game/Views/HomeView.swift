//
//  HomeView.swift
//  Game
//
//  Created by M1 Mac 1 on 1/30/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.white)
                
                VStack {
                    Image(systemName: "square.grid.3x3.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .border(Color.blue)
                    
                }
                .padding(20)
                .multilineTextAlignment(.center)
                
            }
            .frame(width: 80, height: 80)
        }
        Spacer()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
