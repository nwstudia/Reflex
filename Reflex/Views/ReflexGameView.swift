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
            Text("Punkty: \(reflexGameViewModel.score)")
                .padding()
    }

    private var timerView: some View {
        Text("Timer: \(reflexGameViewModel.gameTimerValue, specifier: "%.0f") s")
                       .font(.largeTitle)
                       .padding()
    }

    private var gameBoard: some View {
        CircleView(reflexGameViewModel: reflexGameViewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(CirclePositionModifier(viewModel: reflexGameViewModel))
            .onAppear{
                reflexGameViewModel.startGame()
            }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3)
            .padding(5)
    }


    var body: some View {
        VStack {
            HStack {
                timerView
                Spacer()
                scoreView
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
