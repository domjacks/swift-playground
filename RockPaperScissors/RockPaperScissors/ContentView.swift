//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Dom Jackson on 26/09/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var appChoice = Int.random(in: 0...2)
    @State private var tryingToWin: Bool = Bool.random()
    @State private var gameOver = false
    @State private var questionsAsked = 0
    
    let choices = [("🪨", "✂️"), ("📄", "🪨"), ("✂️", "📄")]
    
    @State private var playerScore = 0
    
    var body: some View {
        VStack {
            
            Text("Try to \(tryingToWin ? "win" : "lose") against \(choices[appChoice].0)")
                .font(.title)
            
            Spacer()
            
            HStack {
                ForEach(choices, id: \.0) { choice in
                    Button(choice.0) {
                        checkSuccess(selected: choice.0, opponent: choices[appChoice].0)
                    }
                    .font(.system(size: 100))
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
    
    func checkSuccess(selected: String, opponent: String) {
        var success: Bool
        let canBeat = choices.first(where: { $0.0 == selected })?.1
        
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
        appChoice = Int.random(in: 0...2)
        tryingToWin.toggle()
    }
    
    func resetGame() {
        playerScore = 0
        questionsAsked = 0
        nextRound()
    }
    
    func printDebug(selected: String, opponent: String, canBeat: String?) {
        print("selected: \(selected)")
        print("opponent: \(opponent)")
        print("trying to win: \(tryingToWin)")
        print("with \(selected), you can beat \(canBeat ?? "nothing")")
    }
}

#Preview {
    ContentView()
}
