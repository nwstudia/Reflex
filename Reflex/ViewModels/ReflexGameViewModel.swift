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
    private var dispresionDuration = 5
    private var lastClicked : String = ""
    
    public static func CreateReflexGame() -> ReflexGameModel
    {
        return ReflexGameModel(
            score: 0,
            proxySize: .zero,
            gameTimerValue: 0,
            circleTarget: ReflexGameModel.CircleTarget(id: UUID().uuidString, color: .green, size: CGFloat(50), isSafe: true, position: .zero, shouldDispersion: false, dispersionDuration: 5),
            playerLives: 3, timeToClick: 8);
    }

    let circleSize: CGFloat = 50
    func setProxySize(proxySize: CGSize){
        gameModel.setProxySize(proxySize)
    }
    
    
    func setDispresion(_ shouldDispresion : Bool)
    {
        gameModel.setDispresion(shouldDispresion)
    }
    
    func calculateScore(){
        if(gameModel.circleTarget.isSafe)
        {
            gameModel.addScore(1)
        }else{
            playerFault();
        }
    }
    
    private func playerFault()
    {
        gameModel.minusScore(1)
        takeLife()
    }
    
    private func takeLife(){
        gameModel.minusLives(1)
        
        if(gameModel.playerLives <= 0)
        {
            endGame();
        }
    }
 
    
    private func generateRandomPosition() -> CGPoint {
        guard gameModel.proxySize.width >= circleSize && gameModel.proxySize.height >= circleSize else {
            return .zero
        }

        let maxX = gameModel.proxySize.width - circleSize
        let maxY = gameModel.proxySize.height - circleSize

        let randomX = CGFloat.random(in: circleSize..<maxX)
        let randomY = CGFloat.random(in: circleSize..<maxY)

        return CGPoint(x: randomX, y: randomY);
    }
    
    func handleCircleTap() {
        if(lastClicked == gameModel.circleTarget.id)
        {
            return;
        }
        lastClicked = gameModel.circleTarget.id;
        CreateNewCircleTarget()
        resetCircleLifetimeTimer(isUserFault: false, isSafe: gameModel.circleTarget.isSafe)
    }
    
    private func CreateNewCircleTarget(){
        if(shouldOccurWithProbability(20))
        {
            gameModel.CreateNewCircleTarget(color: .red, isSafe: false, size: 50, position: generateRandomPosition(), dispersionDuration: 3)
        }else{
            gameModel.CreateNewCircleTarget(color: .green, isSafe: true, size: 50, position: generateRandomPosition(), dispersionDuration: 3)
        }
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
        CreateNewCircleTarget()
        startCircleLifetimeTimer()
    }

    private func startCircleLifetimeTimer() {
        let isSafe = gameModel.circleTarget.isSafe; //avoid clousers
        circleLifetimeTimer = Timer.scheduledTimer(withTimeInterval: gameModel.timeToClick, repeats: false) { [weak self] _ in
            self?.CreateNewCircleTarget()
            self?.resetCircleLifetimeTimer(isUserFault: true, isSafe: isSafe);
        }
    }
    
    private func resetCircleLifetimeTimer(isUserFault : Bool, isSafe:Bool) {
        circleLifetimeTimer?.invalidate()
        if(isUserFault == true && isSafe == true)
        {
            playerFault()
        }
        startCircleLifetimeTimer()
    }
     
    private func shouldOccurWithProbability(_ probability: Int) -> Bool {
        let randomValue = Int.random(in: 1...100)
        return randomValue <= probability
    }
}
