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
    @Published var shouldDispersion: Bool = false
    @Published var dispersionDuration : Double = 0.2
    @Published var gameTimerValue: TimeInterval = 0
    
    private var circleLifetimeTimer: Timer?
    
    private var gameTimer: Timer?
    
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
    func addScore(){
        score += 1
    }
    
    func handleCircleTap() {
        self.shouldDispersion=true;
        resetCircleLifetimeTimer(false)
        generateRandomPosition()
    }
    
    func startGame()
    {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.gameTimerValue += 1
        }
    }
    
    func endGame()
    {
       gameTimer?.invalidate()
    }
    
    func initialSetup(proxySize: CGSize) {
        setProxySize(proxySize: proxySize)
        generateRandomPosition()
        startCircleLifetimeTimer()
    }

    private func startCircleLifetimeTimer() {
        circleLifetimeTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
            self?.generateRandomPosition()
            self?.resetCircleLifetimeTimer(true);
        }
    }
    
    private func resetCircleLifetimeTimer(_ isUserFault : Bool) {
        circleLifetimeTimer?.invalidate()
        if(isUserFault)
        {
            score -= 1
        }
        startCircleLifetimeTimer()
    }

}
