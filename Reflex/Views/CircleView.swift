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
            .fill(.green)
            .frame(width: reflexGameViewModel.circleSize, height: reflexGameViewModel.circleSize)
            .position(reflexGameViewModel.circlePosition)
            .onTapGesture {
                self.reflexGameViewModel.addScore()
                withAnimation(.linear(duration: reflexGameViewModel.dispersionDuration)) {
                            self.reflexGameViewModel.shouldDispersion = true
                           }
                
                           DispatchQueue.main.asyncAfter(deadline: .now() + reflexGameViewModel.dispersionDuration) {
                               withAnimation(nil){
                                   self.reflexGameViewModel.handleCircleTap()
                                   self.reflexGameViewModel.shouldDispersion = false
                               }
                              
                           }
                       }
                       .modifier(DispersionModifier(viewModel: reflexGameViewModel))
    }
}

#Preview {
    return CircleView(reflexGameViewModel: ReflexGameViewModel())
}
