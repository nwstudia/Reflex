//
//  Dispersion.swift
//  Reflex
//
//  Created by user252387 on 12/30/23.
//

import SwiftUI

struct Dispersion: ViewModifier {
    @ObservedObject var viewModel: ReflexGameViewModel
    
    func body(content: Content) -> some View {
        withAnimation(.linear(duration: viewModel.dispersionDuration))
        {
            content
        }.blur(radius:  viewModel.shouldDispersion ? 100 : 1)
    }
}


