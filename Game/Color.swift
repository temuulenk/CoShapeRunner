//
//  Color.swift
//  Game
//
//  Created by Temuulen on 6/10/18.
//  Copyright © 2018 Temuulen. All rights reserved.
//

import Foundation
import SpriteKit


enum Color: String {
    case Red
    case Blue
    case Yellow
    
    func getColor() -> SKColor {
        if(self == Color.Red) {
            return SKColor.red
        }else if(self == Color.Blue) {
            return SKColor.blue
        }else {
            return SKColor.yellow
        }
    }
    
}
