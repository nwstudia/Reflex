//
//  MemoGameModel.swift
//  MemoryGame
//
//  Created by student on 14/11/2023.
//
import Foundation
import SwiftUI

struct ReflexGameModel<CircleContent : Shape>
{
    private(set) var circle : Array<CircleContent>
    private(set) var score : Int
    
    init(score: Int, circleContentFactory: (Int)->
         CircleContent) {
      
        self.score = score
    }
    
    mutating func clicked(_ circle: Circle){
        
    }
    
    struct Circle : Identifiable{
        let color : Color
        let size : CGFloat
        let isSafe : Bool
        let content : CircleContent
        var id : String
    }
    
}



