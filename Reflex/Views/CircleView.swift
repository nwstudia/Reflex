//
//  CircleView.swift
//  Reflex
//
//  Created by user252387 on 12/30/23.
//

import SwiftUI

struct CircleView: View {
    @ObservedObject var reflexGameViewModel: ReflexGameViewModel
    
    var body: some View {
        Circle()
            .fill(reflexGameViewModel.gameModel.circleTarget.color)
            .frame(width: reflexGameViewModel.circleSize, height: reflexGameViewModel.gameModel.circleTarget.size)
            .position(reflexGameViewModel.gameModel.circleTarget.position)
            .onTapGesture {
                self.reflexGameViewModel.addScore()
                withAnimation(.linear(duration: reflexGameViewModel.gameModel.circleTarget.dispersionDuration)) {
                    reflexGameViewModel.setDispresion(true)
                           }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + reflexGameViewModel.gameModel.circleTarget.dispersionDuration) {
                               withAnimation(nil){
                                   self.reflexGameViewModel.handleCircleTap()
                                   self.reflexGameViewModel.setDispresion(false)
                               }
                              
                           }
                       }
                       .modifier(DispersionModifier(viewModel: reflexGameViewModel))
    }
}

#Preview {
    return CircleView(reflexGameViewModel: ReflexGameViewModel())
}
