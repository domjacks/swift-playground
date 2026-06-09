//
//  ContentView.swift
//  WordScramble
//
//  Created by Dom Jackson on 02/10/2025.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        List{
            Text("Static Row")
            
            ForEach(people, id: \.self) {
                Text($0)
            }
            
            Text("Static Row")
        }
    }
}

#Preview {
    ContentView()
}
