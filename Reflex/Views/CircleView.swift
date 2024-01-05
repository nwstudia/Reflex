//
//  CircleView.swift
//  Reflex
//
//  Created by user252387 on 12/30/23.
//

import SwiftUI

struct CircleView: View {
    @ObservedObject var reflexGameViewModel: ReflexGameViewModel

    private var circleView: some View {
        Circle()
            .fill(reflexGameViewModel.gameModel.circleTarget.color)
            .frame(width: reflexGameViewModel.gameModel.circleTarget.size, height: reflexGameViewModel.gameModel.circleTarget.size)
            .position(reflexGameViewModel.gameModel.circleTarget.position)
            .onTapGesture {
                if(!self.reflexGameViewModel.gameModel.circleTarget.shouldDispersion)
                {
                    self.reflexGameViewModel.calculateScore()
                    self.reflexGameViewModel.stopCircleLifetimeTimer()
                    withAnimation(.linear(duration: reflexGameViewModel.gameModel.circleTarget.dispersionDuration)) {
                        reflexGameViewModel.setDispresion(true)
                    }
                    Timer.scheduledTimer(withTimeInterval: reflexGameViewModel.gameModel.circleTarget.dispersionDuration, repeats: false) { timer in
                        withAnimation(nil) {
                            self.reflexGameViewModel.handleCircleTap()
                        }
                    }
                }
            }
             .modifier(DispersionModifier(viewModel: reflexGameViewModel))
                     
    }
    
    var body: some View {
        circleView
    }
}

#Preview {
    return CircleView(reflexGameViewModel: ReflexGameViewModel())
}
