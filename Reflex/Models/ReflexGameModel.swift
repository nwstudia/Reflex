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
    
    init(score : Int, proxySize : CGSize, gameTimerValue : TimeInterval, circleTarget : CircleTarget, playerLives : Int)
    {
        self.score = score
        self.proxySize = proxySize
        self.gameTimerValue = gameTimerValue
        self.circleTarget = circleTarget
        self.playerLives = playerLives
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
    struct CircleTarget {
        var color : Color
        let size : CGFloat
        var isSafe : Bool
        var position: CGPoint
        var shouldDispersion: Bool
        var dispersionDuration : Double
    }
    
}



