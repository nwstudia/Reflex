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
        return ReflexGameModel(
            score: 0,
            proxySize: .zero,
            gameTimerValue: 0,
            circleTarget: ReflexGameModel.CircleTarget(color: .green, size: CGFloat(50), isSafe: true, position: .zero, shouldDispersion: false, dispersionDuration: 0.2),
            playerLives: 3);
    }

    let circleSize: CGFloat = 50
    func setProxySize(proxySize: CGSize){
        gameModel.setProxySize(proxySize)
    }
    
    func generateRandomPosition() {
        getTargetFriendliness();
        guard gameModel.proxySize.width >= circleSize && gameModel.proxySize.height >= circleSize else {
            return
        }

        let maxX = gameModel.proxySize.width - circleSize
        let maxY = gameModel.proxySize.height - circleSize

        let randomX = CGFloat.random(in: circleSize..<maxX)
        let randomY = CGFloat.random(in: circleSize..<maxY)

        gameModel.setPosition(CGPoint(x: randomX, y: randomY))
    }
    
    func getTargetFriendliness()
    {
        if(shouldOccurWithProbability(20))
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
    
    func takeLife(){
        gameModel.minusLives(1)
        
        if(gameModel.playerLives <= 0)
        {
            endGame();
        }
    }
    
    func handleCircleTap() {
        gameModel.setDispresion(true)
        if(gameModel.circleTarget.isSafe == false)
        {
            takeLife()
        }
        generateRandomPosition()
        resetCircleLifetimeTimer(isUserFault: false, isSafe: gameModel.circleTarget.isSafe)
    }
    
    func startGame()
    {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.gameModel.addGameTime(1)
        }
    }
    
    func endGame()
    {
        print("Koniec gry")
       gameTimer?.invalidate()
    }
    
    func initialSetup(proxySize: CGSize) {
        setProxySize(proxySize: proxySize)
        generateRandomPosition()
        startCircleLifetimeTimer()
    }

    private func startCircleLifetimeTimer() {
        let isSafe = gameModel.circleTarget.isSafe; //avoid clousers
        circleLifetimeTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
            self?.generateRandomPosition()
            self?.resetCircleLifetimeTimer(isUserFault: true, isSafe: isSafe);
        }
    }
    
    private func resetCircleLifetimeTimer(isUserFault : Bool, isSafe:Bool) {
        circleLifetimeTimer?.invalidate()
        if(isUserFault == true && isSafe == true)
        {
            gameModel.minusScore(1)
            takeLife()
        }
        startCircleLifetimeTimer()
    }
    
    private func shouldOccurWithProbability(_ probability: Int) -> Bool {
        let randomValue = Int.random(in: 1...100)
        return randomValue <= probability
    }
}
