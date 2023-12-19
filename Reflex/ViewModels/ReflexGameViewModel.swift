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
    @Published var circleModel : ReflexGameModel<Circle> = CreateReflexGame()

    public static func CreateReflexGame() -> ReflexGameModel<Circle>
    {
        return ReflexGameModel<Circle>(score: 4){
            return Circle(endAngle: Angle(degrees: 360))
        }
    }

    var score : Int{
        return circleModel.score
    }
 
    func clicked(_ circle: ReflexGameModel<Circle>.GameElement){
        withAnimation()
        {
            circleModel.clicked(circle)
        }
    }
}
