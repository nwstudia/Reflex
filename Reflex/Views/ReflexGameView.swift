//
//  ThemeButton.swift
//  MemoryGame
//
//  Created by student on 12/12/2023.
//

import SwiftUI
struct CirclePositionModifier: ViewModifier {
    @ObservedObject var viewModel: ReflexGameViewModel

    func body(content: Content) -> some View {
        content
            .overlay(GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        viewModel.setProxySize(proxySize: proxy.size)
                        viewModel.generateRandomPosition()
                    }
                    .onChange(of: proxy.size) { _ in
                        viewModel.setProxySize(proxySize: proxy.size)
                        viewModel.generateRandomPosition()
                    }
            })
    }
}

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
            print("timer fired")
            timeElapsed = Int(Date().timeIntervalSince(startDate))
            if timeElapsed >= 5 {
                startDate = Date()
            }
        }
        .font(.largeTitle)
        .animation(nil)
    }

    private var gameBoard: some View {
        Circle()
            .frame(width: reflexGameViewModel.circleSize, height: reflexGameViewModel.circleSize)
            .position(reflexGameViewModel.circlePosition)
            .onTapGesture {
                self.reflexGameViewModel.handleCircleTap()
            }
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Spacer()
        }
    }
}


#Preview {
    ReflexGameView()
}
