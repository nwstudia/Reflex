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
    @Published var gameModel : ReflexGameModel = CreateReflexGame()

    private var circleLifetimeTimer: Timer?
    
    private var gameTimer: Timer?
    
    public static func CreateReflexGame() -> ReflexGameModel
    {
        return ReflexGameModel(score: 4);
    }

    let circleSize: CGFloat = 50
    func setProxySize(proxySize: CGSize){
        gameModel.setProxySize(proxySize)
    }
    
    func generateRandomPosition() {
        generateCircle();
        guard gameModel.proxySize.width >= circleSize && gameModel.proxySize.height >= circleSize else {
            return
        }

        let maxX = gameModel.proxySize.width - circleSize
        let maxY = gameModel.proxySize.height - circleSize

        let randomX = CGFloat.random(in: circleSize..<maxX)
        let randomY = CGFloat.random(in: circleSize..<maxY)

        gameModel.setPosition(CGPoint(x: randomX, y: randomY))
    }
    
    func generateCircle()
    {
        if(shouldOccurWithProbability(10))
        {
            gameModel.setFriendliness(false)
        }else{
            gameModel.setFriendliness(true)
        }
    }
    
    func setDispresion(_ shouldDispresion : Bool)
    {
        gameModel.setDispresion(shouldDispresion)
    }
    
    func addScore(){
        gameModel.addScore(1)
    }
    
    func handleCircleTap() {
        gameModel.setDispresion(true)
        resetCircleLifetimeTimer(false)
        generateRandomPosition()
    }
    
    func startGame()
    {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.gameModel.addGameTime(1)
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
            gameModel.minusScore(1)
        }
        startCircleLifetimeTimer()
    }
    
    private func shouldOccurWithProbability(_ probability: Int) -> Bool {
        let randomValue = Int.random(in: 1...100)
        return randomValue <= probability
    }
}
