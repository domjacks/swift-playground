//
//  MassiveTextModifier.swift
//  RockPaperScissors
//
//  Created by Dom Jackson on 27/09/2025.
//

import SwiftUI

struct MassiveTextModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 100))
    }
}

extension View {
    func massiveText() -> some View {
        modifier(MassiveTextModifier())
    }
}
