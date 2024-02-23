//
//  GameOverView.swift
//  Hizibizi Guess
//
//  Created by Rakibul Nasib on 22/11/23.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject  var matchManager: MatchManager
    var body: some View {
        VStack{
            Spacer()
            
            Image("gameOver")
                .resizable()
                .scaledToFit()
                .padding(.horizontal,70).padding(.vertical)
            Text("Score: \(matchManager.score)").font(.largeTitle).bold().foregroundColor(Color("primaryYellow"))
            Spacer()
            
            Button
            {
              
            }label:{
                Text("MENU").foregroundColor(Color("menuBtn")).brightness(-0.4).font(.largeTitle).bold()
                
            }
            .padding(.vertical,20)
            .padding(.horizontal,50)
            .background(
                Capsule(style: .circular).fill(Color("menuBtn"))
            ).padding(.top,100)
            
            
            Spacer()
            
        }
        .background(
            Image("gameOverBg").resizable().scaledToFill().scaleEffect(1.2)
        ).ignoresSafeArea()
    }
    
}


#Preview {
    GameOverView(matchManager: MatchManager())
}
