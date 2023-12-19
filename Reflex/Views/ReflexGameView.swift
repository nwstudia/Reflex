//
//  ThemeButton.swift
//  MemoryGame
//
//  Created by student on 12/12/2023.
//

import SwiftUI

struct ReflexGameView: View {
    @State var startDate = Date.now
    @State var timeElapsed: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var score : some View{
        Text("Score: 0")
            .animation(nil)
    }
    
    private var timerView : some View{
        Text("Timer: \(timeElapsed)")    .onReceive(timer) { firedDate in
            
            print("timer fired")
            // 3
            timeElapsed = Int(firedDate.timeIntervalSince(startDate))
            if(timeElapsed >= 5)
            {
                startDate = Date.now
            }
        }
        .font(.largeTitle)
            .animation(nil)
    }
    
    private var GameBoard : some View{
        Text("TODO: there will be shapes genereted")
    }
    
    var body: some View {
        VStack{
            HStack{
                timerView
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
