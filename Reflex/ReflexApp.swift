//
//  ReflexApp.swift
//  Reflex
//
//  Created by student on 12/12/2023.
//

import SwiftUI

@main
struct ReflexApp: App {
    @StateObject var reflexGameViewModel: ReflexGameViewModel = ReflexGameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(reflexGameViewModel: reflexGameViewModel)
        }
    }
}
