//
//  ContentView.swift
//  Reflex
//
//  Created by student on 12/12/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var reflexGameViewModel: ReflexGameViewModel = ReflexGameViewModel()
    
    var body: some View {
        VStack {
            ReflexGameView(reflexGameViewModel: reflexGameViewModel)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
