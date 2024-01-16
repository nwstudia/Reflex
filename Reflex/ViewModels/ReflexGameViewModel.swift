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
    @Published private var gameModel : ReflexGameModel = CreateReflexGame()
    private var circleLifetimeTimer: Timer?
    private var gameTimer: Timer?
    private var dispresionDuration = 5
    private var lastClicked : String = ""
    
    public func getIsGameInProgress() -> Bool {
        return gameModel.isGameEnded;
    }
   
    
    public static func CreateReflexGame() -> ReflexGameModel
    {
        return ReflexGameModel(
            score: 0,
            proxySize: .zero,
            gameTimerValue: 0,
            circleTarget: ReflexGameModel.CircleTarget(id: UUID().uuidString, color: .green, size: CGFloat(50), isSafe: true, position: .zero, shouldDispersion: false, dispersionDuration: 1, timeToClick: 3),
            playerLives: 3);
    }

    let circleSize: CGFloat = 50
    
    func setProxySize(proxySize: CGSize){
        gameModel.setProxySize(proxySize)
    }
    
    var GameTimer : TimeInterval
    {
        return gameModel.gameTimerValue;
    }
    var GameScore : Int
    {
        return gameModel.score;
    }
    
    var PlayerLives : Int{
        return gameModel.playerLives;
    }
    
    var GameEnded : Bool {
        get{
            return gameModel.isGameEnded
        }set{
            gameModel.isGameEnded = newValue
        }
    }
    var CircleTarget : ReflexGameModel.CircleTarget
    {
        return gameModel.circleTarget;
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
    private var colors : [Color] = [.green, .yellow, .blue, .orange, .black]
    
    private func CreateNewCircleTarget(){
        guard !gameModel.isGameEnded else {return;}
        
        var divider =  gameModel.gameTimerValue/10;
        if(gameModel.gameTimerValue<10)
        {
            divider = 1.5;
        }else if(gameModel.gameTimerValue<20)
        {
            divider = 3;
        }else if(gameModel.gameTimerValue<30)
        {
            divider=3.5;
        }else if(gameModel.gameTimerValue<40)
        {
            divider=3.6;
        }else
        {
            divider=3.8;
        }
       
        if(shouldOccurWithProbability(20))
        {
            gameModel.CreateNewCircleTarget(color: .red, isSafe: false, size: 50, position: generateRandomPosition(), dispersionDuration: 2/divider, timeToClick: 3/divider)
        }else{
            gameModel.CreateNewCircleTarget(color: colors.randomElement() ?? .green, isSafe: true, size: 50, position: generateRandomPosition(), dispersionDuration: 2/divider, timeToClick: 3/divider)
        }
    }
    
    func reset() {
        gameModel.setScore(0)
        gameModel.setGameTimerValue(0)
        gameModel.setPlayerLives(3)
        gameModel.setIsGameEnded(false);
    }
    
    func startGame()
    {
        reset();
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.gameModel.addGameTime(1)
        }
        stopCircleLifetimeTimer()
        CreateNewCircleTarget()
        startCircleLifetimeTimer()
    }
    
    func endGame()
    {
        gameTimer?.invalidate()
        stopCircleLifetimeTimer()
        gameModel.setIsGameEnded(true);
    }
    
    func initialSetup(proxySize: CGSize) {
        setProxySize(proxySize: proxySize)
        CreateNewCircleTarget()
        startCircleLifetimeTimer()
    }

    private func startCircleLifetimeTimer() {
        let isSafe = gameModel.circleTarget.isSafe; //avoid clousers
        self.circleLifetimeTimer = Timer.scheduledTimer(withTimeInterval: gameModel.circleTarget.timeToClick, repeats: false) { [weak self] _ in
            if let isGameEnded = self?.gameModel.isGameEnded, !isGameEnded {
                   self?.CreateNewCircleTarget()
                   self?.resetCircleLifetimeTimer(isUserFault: true, isSafe: isSafe)
               }
        }
    }
    func stopCircleLifetimeTimer()
    {
        circleLifetimeTimer?.invalidate()
    }
    private func resetCircleLifetimeTimer(isUserFault : Bool, isSafe:Bool) {
        stopCircleLifetimeTimer()
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
