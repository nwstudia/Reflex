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
            .fill(reflexGameViewModel.CircleTarget.color)
            .frame(width: reflexGameViewModel.CircleTarget.size, height: reflexGameViewModel.CircleTarget.size)
            .position(reflexGameViewModel.CircleTarget.position)
            .onTapGesture {
                if(!self.reflexGameViewModel.CircleTarget.shouldDispersion)
                {
                    self.reflexGameViewModel.calculateScore()
                    self.reflexGameViewModel.stopCircleLifetimeTimer()
                    withAnimation(.linear(duration: reflexGameViewModel.CircleTarget.dispersionDuration)) {
                        reflexGameViewModel.setDispresion(true)
                    }
                    Timer.scheduledTimer(withTimeInterval: reflexGameViewModel.CircleTarget.dispersionDuration, repeats: false) { timer in
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
