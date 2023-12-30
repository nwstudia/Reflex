//
//  CirclePositionModifier.swift
//  Reflex
//
//  Created by user252387 on 12/30/23.
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
