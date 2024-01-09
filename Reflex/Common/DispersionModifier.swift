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
        withAnimation(.linear(duration: viewModel.CircleTarget.dispersionDuration))
        {
            content.opacity(viewModel.CircleTarget.shouldDispersion ? 0 : 1)

        }.blur(radius:  viewModel.CircleTarget.shouldDispersion ? 20 : 1)
       }
}


