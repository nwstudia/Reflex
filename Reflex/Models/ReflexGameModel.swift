//
//  MemoGameModel.swift
//  MemoryGame
//
//  Created by student on 14/11/2023.
//
import Foundation
import SwiftUI

struct ReflexGameModel<CardContent : Equatable, Shape>
{
    private(set) var circle : Array<Circle>
    
    
    struct Circle : Equatable, Identifiable{
        let content : CardContent
        var id : String
    }
    
}



