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
    @Published var circleModel : ReflexGameModel = CreateReflexGame()

    public static func CreateReflexGame() -> ReflexGameModel
    {
        return ReflexGameModel(score: 4);
    }

    var scoree : Int{
        return circleModel.score
    }
 
    func clicked(_ circle: ReflexGameModel.GameElement){
        withAnimation()
        {
            circleModel.clicked(circle)
            
        }
    }
    //
    @Published var circlePosition: CGPoint = .zero
    @Published var score: Int = 0
    @Published var proxySize: CGSize = .zero
    let circleSize: CGFloat = 50
    func setProxySize(proxySize: CGSize){
        self.proxySize = proxySize
    }
    func generateRandomPosition() {
        guard proxySize.width >= circleSize && proxySize.height >= circleSize else {
            return
        }

        let maxX = proxySize.width - circleSize
        let maxY = proxySize.height - circleSize

        let randomX = CGFloat.random(in: 0..<maxX)
        let randomY = CGFloat.random(in: 0..<maxY)

        circlePosition = CGPoint(x: randomX, y: randomY)
    }

    func handleCircleTap() {
        score += 1
        generateRandomPosition()
    }


    private func generateRandomPositionWithinBounds() {
        let maxX = UIScreen.main.bounds.width - circleSize
        let maxY = UIScreen.main.bounds.height - circleSize

        let randomX = CGFloat.random(in: circleSize..<maxX)
        let randomY = CGFloat.random(in: circleSize..<maxY)

        circlePosition = CGPoint(x: randomX, y: randomY)
    }
    //

}
