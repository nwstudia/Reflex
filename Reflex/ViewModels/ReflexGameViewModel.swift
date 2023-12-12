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
    @Published var circleModel : ReflexGameModel<Circle>


    public static func CreateReflexGame() -> ReflexGameModel<Circle>
    {
        return ReflexGameModel<Circle>()
    }


    var score : Int{
        return circleModel.score
    }
 
    func clicked(_ circle: ReflexGameModel<Circle>.Circle){
        withAnimation()
        {
            circleModel.clicked(circle)
        }
    }

}

