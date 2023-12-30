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
    private(set) var circle : Array<GameElement>
    private(set) var score : Int
    
    init(score: Int) {
        circle=[]
        
        self.score = score
        
        circle.append(
            GameElement(color: .green, size: 4, isSafe: true, id: "1"))
        circle.append(
            GameElement(color: .red, size: 4,isSafe: false, id: "2"))
        
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
        var id : String
    }
    
}



