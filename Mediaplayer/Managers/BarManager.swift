//
//  BarManager.swift
//  Mediaplayer
//
//  Created by dorian on 02/08/2022.
//

import Foundation
import SwiftUI

class BarManager: ObservableObject {
    @Published var bars: [Bar] = []
    
    let topColor: Color = Color(red:0.51, green: 0.20, blue:0.69)
    let bottomColor: Color = Color(red:0.32, green: 0.36, blue:0.83)

    
    let barMaxHeight: CGFloat = 200
    let barMinHeight: CGFloat = 100
    let barWidth: CGFloat = 20
    
    let loopTime: Double = 1.5
    
    init() {
        for i in 0..<4 {
            self.bars.append(Bar(id:i, height: self.barMinHeight))
        }
    }
    
    func startAnimation() {
        for i in 1..<(self.bars.count+1) {
            let speedUp = (loopTime/3) / Double(i)
            let speedDown = speedUp * 3
            Timer.scheduledTimer(withTimeInterval: speedUp+speedDown, repeats: true){_ in
                withAnimation(Animation.linear(duration: speedUp)) {
                    self.bars[i-1].height = self.barMaxHeight
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+speedUp){
                    withAnimation(Animation.linear(duration: speedDown)) {
                        self.bars[i-1].height = self.barMinHeight
                    }
                }
            }
        }
    }
    
}
