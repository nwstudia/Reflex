//
//  ThemeButton.swift
//  MemoryGame
//
//  Created by student on 12/12/2023.
//

import SwiftUI




struct ReflexGameView: View {
    @StateObject var reflexGameViewModel: ReflexGameViewModel = ReflexGameViewModel()
    @State private var startDate = Date()
    @State private var timeElapsed: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var scoreView: some View {
            Text("Punkty: \(reflexGameViewModel.score)")
                .padding()
    }

    private var timerView: some View {
        Text("Timer: \(timeElapsed)").onReceive(timer) { _ in
            
            timeElapsed = Int(Date().timeIntervalSince(startDate))
            if timeElapsed >= 5 {
                startDate = Date()
            }
        }
        .font(.largeTitle)
    }

    private var gameBoard: some View {
        CircleView(reflexGameViewModel: reflexGameViewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(CirclePositionModifier(viewModel: reflexGameViewModel))
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
