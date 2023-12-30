//
//  ReflexGameViewModel.swift
//  Reflex
//
//  Created by student on 12/12/2023.
//
import Foundation
import SwiftUI

class ReflexGameViewModel : ObservableObject
{
    @Published var circleModel : ReflexGameModel = CreateReflexGame()
    @Published var circlePosition: CGPoint = .zero
    @Published var score: Int = 0
    @Published var proxySize: CGSize = .zero
    @Published var shouldThrob: Bool = false
    @Published var throbDuration : Double = 0.2
    
    private var timer: Timer?
    
    public static func CreateReflexGame() -> ReflexGameModel
    {
        return ReflexGameModel(score: 4);
    }

    
    let circleSize: CGFloat = 50
    func setProxySize(proxySize: CGSize){
        self.proxySize = proxySize
    }
    
    func generateRandomPosition() {
        guard proxySize.width >= circleSize && proxySize.height >= circleSize else {
            return
        }

        let maxX = proxySize.width - circleSize
        let maxY = proxySize.height - circleSize

        let randomX = CGFloat.random(in: circleSize..<maxX)
        let randomY = CGFloat.random(in: circleSize..<maxY)

        circlePosition = CGPoint(x: randomX, y: randomY)
    }

    func handleCircleTap() {
        self.shouldThrob=true;
        score += 1
        resetTimer(false)
        generateRandomPosition()
    }

    func initialSetup(proxySize: CGSize) {
        setProxySize(proxySize: proxySize)
        generateRandomPosition()
        startTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
            self?.generateRandomPosition()
            self?.resetTimer(true);
        }
    }

    private func resetTimer(_ isUserFault : Bool) {
        timer?.invalidate()
        if(isUserFault)
        {
            score -= 1
        }
        startTimer()
    }

}
