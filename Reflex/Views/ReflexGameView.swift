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
                        viewModel.initialSetup(proxySize: proxy.size)
                    }
                    .onChange(of: proxy.size) { _ in
                        viewModel.initialSetup(proxySize: proxy.size)
                    }
            })
    }
}
struct Glow: ViewModifier {
    @ObservedObject var viewModel: ReflexGameViewModel
    
    func body(content: Content) -> some View {
        withAnimation(.linear(duration: viewModel.throbDuration))
        {
            content
        }.blur(radius:  viewModel.shouldThrob ? 100 : 1)
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
            .fill(.green)
            .frame(width: reflexGameViewModel.circleSize, height: reflexGameViewModel.circleSize)
            .position(reflexGameViewModel.circlePosition)
            .onTapGesture {
                withAnimation(.linear(duration: reflexGameViewModel.throbDuration)) {
                               self.reflexGameViewModel.shouldThrob = true
                           }
                           DispatchQueue.main.asyncAfter(deadline: .now() + reflexGameViewModel.throbDuration) {
                               withAnimation(nil){
                                   self.reflexGameViewModel.handleCircleTap()
                                   self.reflexGameViewModel.shouldThrob = false
                               }
                              
                           }
                       }
                       .modifier(Glow(viewModel: reflexGameViewModel))
           
         
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
                .modifier(CirclePositionModifier(viewModel: reflexGameViewModel))
            Spacer()
        }
    }
}


#Preview {
    ReflexGameView()
}
