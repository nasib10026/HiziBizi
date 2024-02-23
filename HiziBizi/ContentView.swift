import SwiftUI

struct ContentView: View {
    @State private var isGameActive = false
    @AppStorage("uid") var userID: String = ""
    var body: some View {
        if userID == "" {
                    AuthView()
        } else {
            if isGameActive {
                GameView(matchManager: MatchManager())
            } else {
                MenuView(matchManager: MatchManager(), isGameActive: $isGameActive)
            }
        }
        
        /**/
    }
}
