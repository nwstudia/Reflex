//
//  ThemeButton.swift
//  MemoryGame
//
//  Created by student on 12/12/2023.
//

import SwiftUI

struct ReflexGameView: View {
    @ObservedObject var reflexGameViewModel: ReflexGameViewModel 
    
    init(reflexGameViewModel: ReflexGameViewModel) {
        self.reflexGameViewModel = reflexGameViewModel
    }

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
                .alert(isPresented: $reflexGameViewModel.gameModel.isGameEnded) {
                Alert(
                    title: Text("Gra skonczona"),
                    message: Text("Uzyskales \(reflexGameViewModel.gameModel.score) punktow w czasie \(reflexGameViewModel.gameModel.gameTimerValue, specifier: "%.0f") s"),
                    dismissButton: .default(Text("Zagraj ponownie")) {
                        reflexGameViewModel.startGame()
                    }
                )
            }
            Spacer()
        }
    }
}

#Preview {
    ReflexGameView(reflexGameViewModel: ReflexGameViewModel())
}
