//
//  Untitled.swift
//  RockPaperScissors
//
//  Created by Dom Jackson on 27/09/2025.
//

enum RPSChoice: CaseIterable, Equatable {
    case rock, paper, scissors
    
    var emoji: String {
        switch self {
        case .rock: return "🪨"
        case .paper: return "📄"
        case .scissors: return "✂️"
        }
    }
    
    var beats: RPSChoice {
        switch self {
        case .rock: return .scissors
        case .paper: return .rock
        case .scissors: return .paper
        }
    }
}
