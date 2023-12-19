//
//  MemoGameModel.swift
//  MemoryGame
//
//  Created by student on 14/11/2023.
//
import Foundation
import SwiftUI

struct ReflexGameModel<GameElementContent : Shape>
{
    private(set) var circle : Array<GameElement>
    private(set) var score : Int
    
    init(score: Int, circleContentFactory: ()->
         GameElementContent) {
        circle=[]
        
        self.score = score
        let content = circleContentFactory()
        
        circle.append(
            GameElement(color: .green, size: 4, isSafe: true, content: content, id: "1"))
        circle.append(
            GameElement(color: .red, size: 4,isSafe: false, content: content, id: "2"))
        
    }
    
    mutating func clicked(_ circle: GameElement){
        if(circle.isSafe)
        {
            score+=1
        }else{
            //end game;
        }
    }
    
    struct GameElement : Identifiable{
        let color : Color
        let size : CGFloat
        let isSafe : Bool
        let content : GameElementContent
        var id : String
    }
    
}



