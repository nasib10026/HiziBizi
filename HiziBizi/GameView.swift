//
//  GameView.swift
//  Hizibizi Guess
//
//  Created by Rakibul Nasib on 22/11/23.
//
import Foundation
import Combine
import SwiftUI

class TimerManager: ObservableObject {
    @Published var countDownTimer: Int = 100
    private var timer: Timer?

    func startTimer() {
        // Invalidate the existing timer if it's already running
        timer?.invalidate()

        // Initialize and start the timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] _ in
            DispatchQueue.main.async {
                if self.countDownTimer > 0 {
                    self.countDownTimer -= 1
                } else {
                    self.timer?.invalidate()
                }
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }

    deinit {
        stopTimer()
    }
}


struct GameView: View {
    @ObservedObject var matchManager: MatchManager
    @State var drawingGuess = ""
    @State var eraserEnabled = false
    @State var userInput=""
    @State var isDrawingCleared = false
    @State var countDownTimer = 100
    @State var timerRunning =  true
    @StateObject var timerManager = TimerManager()
    
    func makeGuess(){
        matchManager.submitGuess(guess: drawingGuess)
        drawingGuess = ""
        if matchManager.correctGuess {
              isDrawingCleared = true // Set this flag to indicate the drawing should be cleared
              matchManager.correctGuess = false // Reset the correctness flag
          }
    }


    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                Image(matchManager.currentlyDrawing ? "drawerBg" : "guesserBg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .scaleEffect(1.1)
                
                VStack {
                    topBarView
                    gameContentView
                    bottomBarView
                }
                .padding(.horizontal, 30)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        } .onAppear {
            timerManager.startTimer()
        }
        
    }
    
    var topBarView: some View {
        HStack {
          
            
            Spacer()
            
            Label("\(countDownTimer)", systemImage: "clock.fill")
                .bold()
                .font(.title2)
                .foregroundColor(Color(matchManager.currentlyDrawing ? "primaryYellow" : "primaryPurple"))
            
            Text("Score: \(matchManager.score)")
                .bold()
                .font(.title)
                .foregroundColor(Color(matchManager.currentlyDrawing ? "primaryYellow" : "primaryPurple"))
        }
        .padding(.vertical, 15)
    }
    
    
    var gameContentView: some View {
        ZStack {
            if matchManager.currentPlayer == .drawer {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            eraserEnabled.toggle()
                        }) {
                            Image(systemName: eraserEnabled ? "eraser.fill" : "eraser")
                                .font(.title)
                                .foregroundColor(Color("primaryPurple"))
                                .padding(.top, 10)
                        }
                    }
                
                    DrawingView(matchManager: matchManager, eraserEnabled: $eraserEnabled)
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 10))
                }
            } else {
                // Guessing interface
                VStack {
                    TextField("Type your guess", text: $drawingGuess)
                        .padding()
                        .background(Capsule().fill(Color.white))
                    Button("Submit Guess") {
                        matchManager.submitGuess(guess: drawingGuess)
                        drawingGuess = ""
                    }
                }
            }
        }

    }
    
    var bottomBarView: some View {
        VStack {
            // Displaying past guesses
            if !matchManager.pastGuesses.isEmpty {
                Text("Past Guesses")
                    .font(.headline)
                    .padding(.top)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(matchManager.pastGuesses, id: \.self) { guess in
                            Text(guess.message)
                                .font(.body)
                                .foregroundColor(guess.correct ? .green : .red)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: 150)
            }
            
            // Clear past guesses button
//            Button("Submit Guess") {
//                matchManager.submitGuess(guess: drawingGuess)
//                drawingGuess = ""
//            }
            
            // Include a submit button for the drawer
            VStack{    if matchManager.currentlyDrawing{
                Label("DRAW:",systemImage: "exclamationmark.bubble.fill").font(.title2).bold().foregroundColor(.white)
                Text(matchManager.drawPrompt.uppercased()).font(.largeTitle).bold().padding().foregroundColor(Color("primaryYellow"))
                Button("Submit Drawing") {
                    
                    matchManager.submitDrawing()
                }
            }  else{
                HStack{
                    Label("GUESS THE HIZIBIZI :",systemImage: "exclamationmark.bubble.fill").font(.title2).bold().foregroundColor(Color("primaryPurple"))
                    Spacer()
                }
                HStack {
                    TextField("Type your guess",text: $drawingGuess).padding().background(
                        Capsule(style: .circular).fill(.white)
                    ).onSubmit(makeGuess)
                    
                    Button{
                        makeGuess()
                    }label:{
                        Image(systemName: "chevron.right.circle.fill").renderingMode(.original).foregroundColor(Color("primaryPurple")).font(.system(size: 50))
                    }
                }
            }
            }.frame(maxWidth: .infinity).padding([.horizontal,.bottom],30).padding(.vertical).background((matchManager.currentlyDrawing ? Color(red: 0.243, green: 0.773, blue: 0.745):Color("primaryYellow")).opacity(0.5).brightness(-0.2)
            )
        
        }
    }
    
}
#Preview {
    GameView(matchManager: MatchManager())
}
