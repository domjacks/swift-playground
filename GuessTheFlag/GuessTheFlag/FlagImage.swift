//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Dom Jackson on 26/09/2025.
//

import SwiftUI

struct FlagImage: View {
    let country: String
    
    init(_ country: String) {
        self.country = country
    }
    
    var body: some View {
        Image(country).clipShape(.capsule).shadow(radius: 5)
    }
}
