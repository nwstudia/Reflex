//
//  GameTarget.swift
//  Reflex
//
//  Created by user252387 on 12/26/23.
//

import SwiftUI

struct circleTarget: View {
    
    var body: some View {
        Circle()
            .fill(.green)
            .frame(width: 100, height: 100)
            .onTapGesture {
                print("click")
            }
    }
}

#Preview {
    circleTarget()
}
