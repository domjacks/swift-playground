//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Dom Jackson on 26/09/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var appChoice = RPSChoice.allCases.randomElement()!
    @State private var tryingToWin: Bool = Bool.random()
    @State private var gameOver = false
    @State private var questionsAsked = 0
    
    let choices = RPSChoice.allCases
    
    @State private var playerScore = 0
    
    var body: some View {
        VStack {
            Text("Try to \(tryingToWin ? "win" : "lose") against \(appChoice.emoji)")
                .font(.title)
            Spacer()
            HStack {
                ForEach(choices, id: \ .self) { choice in
                    Button(choice.emoji) {
                        checkSuccess(selected: choice, opponent: appChoice)
                    }
                    .massiveText()
                }
            }
            Spacer()
            Text("Score: \(playerScore)")
                .font(.title)
        }
        .alert("Game over!", isPresented: $gameOver) {
            Button("Restart") {
                resetGame()
            }
        } message: {
            Text("You scored: \(playerScore) out of 3")
        }
    }
    
    func checkSuccess(selected: RPSChoice, opponent: RPSChoice) {
        var success: Bool
        let canBeat = selected.beats
        printDebug(selected: selected, opponent: opponent, canBeat: canBeat)
        if selected == opponent {
            success = false
        }
        else if tryingToWin {
            success = canBeat == opponent
        } else {
            success = canBeat != opponent
        }
        if success {
            playerScore += 1
        }
        questionsAsked += 1
        if questionsAsked >= 3 {
            gameOver = true
        } else {
            nextRound()
        }
    }
    
    func nextRound() {
        appChoice = RPSChoice.allCases.randomElement()!
        tryingToWin.toggle()
    }
    
    func resetGame() {
        playerScore = 0
        questionsAsked = 0
        nextRound()
    }
    
    func printDebug(selected: RPSChoice, opponent: RPSChoice, canBeat: RPSChoice) {
        print("selected: \(selected.emoji)")
        print("opponent: \(opponent.emoji)")
        print("trying to win: \(tryingToWin)")
        print("with \(selected.emoji), you can beat \(canBeat.emoji)")
    }
}

#Preview {
    ContentView()
}
