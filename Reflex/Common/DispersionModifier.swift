//
//  Dispersion.swift
//  Reflex
//
//  Created by user252387 on 12/30/23.
//

import SwiftUI

struct DispersionModifier: ViewModifier {
    @ObservedObject var viewModel: ReflexGameViewModel
    
    func body(content: Content) -> some View {
        withAnimation(.linear(duration: viewModel.gameModel.circleTarget.dispersionDuration))
        {
            content.opacity(viewModel.gameModel.circleTarget.shouldDispersion ? 0 : 1)

        }.blur(radius:  viewModel.gameModel.circleTarget.shouldDispersion ? 20 : 1)
       }
}


