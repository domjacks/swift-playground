//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dom Jackson on 19/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }

            Text("Your content")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    ContentView()
}
