//
//  MemoGameModel.swift
//  MemoryGame
//
//  Created by student on 14/11/2023.
//
import Foundation
import SwiftUI

struct ReflexGameModel
{
    private(set) var score: Int
    private(set) var proxySize: CGSize
    private(set) var gameTimerValue: TimeInterval
    private(set) var circleTarget : CircleTarget
    private(set) var playerLives : Int
    var isGameEnded : Bool = false
    
    init(score : Int, proxySize : CGSize, gameTimerValue : TimeInterval, circleTarget : CircleTarget, playerLives : Int)
    {
        self.score = score
        self.proxySize = proxySize
        self.gameTimerValue = gameTimerValue
        self.circleTarget = circleTarget
        self.playerLives = playerLives
    }
    mutating func setIsGameEnded(_ isGameEnded : Bool){
        self.isGameEnded = isGameEnded
    }
    mutating func setPlayerLives(_ playerLives : Int)
    {
        self.playerLives=playerLives;
    }
    mutating func setGameTimerValue(_ gameTimerValue : TimeInterval)
    {
        self.gameTimerValue = gameTimerValue
    }
    mutating func setScore(_ score : Int)
    {
        self.score = score
    }
    mutating func setProxySize(_ size : CGSize)
    {
        self.proxySize = size;
    }
    
    mutating func setPosition(_ position : CGPoint)
    {
        circleTarget.position = position;
    }
    
    mutating func addGameTime(_ time : TimeInterval){
        gameTimerValue += time
    }
    
    mutating func setFriendliness(_ isFriendly : Bool)
    {
        circleTarget.isSafe = isFriendly;
        circleTarget.color = isFriendly ? .green : .red;
    }
    
    mutating func setDispresion(_ shouldDispresion : Bool)
    {
        self.circleTarget.shouldDispersion = shouldDispresion
    }
    
    mutating func addScore(_ howMany : Int){
        score += howMany;
    }
    
    mutating func minusScore(_ howMany : Int){
        score -= howMany;
    }
    
    mutating func minusLives(_ howMany : Int){
        playerLives -= howMany;
    }
    
    mutating func CreateNewCircleTarget(color : Color, isSafe: Bool, size : CGFloat, position : CGPoint, dispersionDuration : Double, timeToClick : TimeInterval) {
        self.circleTarget = CircleTarget(id:  UUID().uuidString, color: color, size: size, isSafe: isSafe, position: position, shouldDispersion: false, dispersionDuration: dispersionDuration, timeToClick: timeToClick)
    }
    
    struct CircleTarget : Identifiable{
        var id: String
        var color : Color
        var size : CGFloat
        var isSafe : Bool
        var position: CGPoint
        var shouldDispersion: Bool
        var dispersionDuration : Double
        var timeToClick : TimeInterval
    }
    
}



