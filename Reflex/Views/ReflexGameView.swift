//
//  ThemeButton.swift
//  MemoryGame
//
//  Created by student on 12/12/2023.
//

import SwiftUI

struct ReflexGameView: View {
    private var score : some View{
        Text("Score: 0")
            .animation(nil)
    }
    
    private var timer : some View{
        Text("Timer: 30")
            .animation(nil)
    }
    
    private var GameBoard : some View{
        Text("TODO: there will be shapes genereted")
    }
    
    var body: some View {
        VStack{
            HStack{
                timer
                Spacer()
                score
            }
            Spacer()
            GameBoard
            Spacer()
        }
    }
}

#Preview {
    ReflexGameView()
}
