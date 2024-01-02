//
//  ThemeButton.swift
//  MemoryGame
//
//  Created by student on 12/12/2023.
//

import SwiftUI

struct ReflexGameView: View {
    @StateObject var reflexGameViewModel: ReflexGameViewModel = ReflexGameViewModel()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var scoreView: some View {
        Text("Punkty: \(reflexGameViewModel.gameModel.score)")
                .padding()
    }

    private var timerView: some View {
        Text("Czas: \n  \(reflexGameViewModel.gameModel.gameTimerValue, specifier: "%.0f") s")
                       .font(.largeTitle)
                       .padding()
    }
    private var playerLives : some View {
        Text("Zycia gracza: \(reflexGameViewModel.gameModel.playerLives) /3")
                       .padding()
    }
    
    private var gameBoard: some View {
        CircleView(reflexGameViewModel: reflexGameViewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(CirclePositionModifier(viewModel: reflexGameViewModel))
            .onAppear{
                reflexGameViewModel.startGame()
            }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3)
    }


    var body: some View {
        VStack {
            HStack {
                timerView
                scoreView
                playerLives
            }
            Spacer()
            gameBoard
            Spacer()
        }
    }
}


#Preview {
    ReflexGameView()
}
