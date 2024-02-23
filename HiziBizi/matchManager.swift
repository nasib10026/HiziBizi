//
//  matchManager.swift
//  HiziBizi
//
//  Created by Rakibul Nasib on 27/11/23.
//

import Foundation
import PencilKit
import Combine


class MatchManager:  ObservableObject {
    @Published var inGame = true
    @Published var isGameOver = false
    @Published var authenticationState = PlayerAuthState.authenticating
    @Published var isTimeKeeper = false
    
    @Published var currentlyDrawing = true
    @Published var drawPrompt = everydayObjects.randomElement()!
    @Published var pastGuesses = [PastGuess]()
    
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining
    @Published var currentPlayer: PlayerRole = .drawer
    @Published var attemptsLeft = 3
    @Published var correctGuess = false
    
    
    enum PlayerRole {
            case drawer, guesser
        }

        func submitDrawing() {
            // Logic to submit drawing
            switchToGuesser()
        }
    

    func submitGuess(guess: String) {
        // Check if the guess is correct
        if guess.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == drawPrompt.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
            // Increase the score
            score += 2  // or any other value you prefer

            // Set correctGuess to true
            correctGuess = true
            resetDrawing()

            // Perform any other necessary actions
            // e.g., switch roles, reset attempts, etc.
            switchRoles()
        } else {
            // If the guess is wrong, reduce the attempts left
            attemptsLeft -= 1
            if attemptsLeft == 0 {
                // Perform actions when no attempts left
                resetDrawing() 
                switchRoles()
            }
        }
    }

      
     func resetDrawing() {
          inGame = false
          currentlyDrawing = true
          drawPrompt = everydayObjects.randomElement()!
          pastGuesses.removeAll()
      }
      
    func switchToGuesser() {
            currentlyDrawing =  false
            inGame = true
            //currentPlayer = .guesser
            attemptsLeft = 3
            
        }

      func switchRoles() {
            currentlyDrawing = true
            resetGame()
        }
    
    func resetGame()
    {
        drawPrompt = everydayObjects.randomElement()!
        //canvasView.drawing = PKDrawing()
    }
    
}
    

