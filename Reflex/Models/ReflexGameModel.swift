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
    private(set) var score: Int = 0
    private(set) var proxySize: CGSize = .zero
    private(set) var shouldDispersion: Bool = false
    private(set) var dispersionDuration : Double = 0.2
    private(set) var gameTimerValue: TimeInterval = 0
    private(set) var circleTarget = CircleTarget(color: .green, size: CGFloat(50), isSafe: true, position: .zero)
    
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
        self.shouldDispersion = shouldDispresion
    }
    mutating func addScore(_ howMany : Int){
        score += howMany;
    }
    
    mutating func minusScore(_ howMany : Int){
        score -= howMany;
    }
    
    struct CircleTarget {
        var color : Color
        let size : CGFloat
        var isSafe : Bool
        var position: CGPoint
    }
    
}



