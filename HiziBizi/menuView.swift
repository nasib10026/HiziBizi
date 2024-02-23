//
//  menuView.swift
//  HiziBizi
//
//  Created by Rakibul Nasib on 27/11/23.
//




import SwiftUI

struct MenuView: View {
    @ObservedObject  var matchManager: MatchManager
    @Binding var isGameActive: Bool
    var body: some View {
        VStack{
            Spacer()
            
            Image("logo")
            .resizable()
            .scaledToFit()
            .padding(.top,70)
            
            Spacer()
            
            Button
            {
                isGameActive = true
            }label:{
                Text("PLAY").foregroundColor(.white).font(.largeTitle).bold()
                
            }
            .padding(.vertical,20)
            .padding(.horizontal,100)
            .background(
                Capsule(style: .circular).fill(matchManager.authenticationState != .authenticated || matchManager.inGame ? .gray : Color("playBtn"))
            ).padding(.top,100)
            
            
            Spacer()

        }
        .background(
            Image("background").resizable().scaledToFill()
        ).ignoresSafeArea()
    }
}

#Preview {
    MenuView(matchManager: MatchManager(),isGameActive: .constant(false))
}
