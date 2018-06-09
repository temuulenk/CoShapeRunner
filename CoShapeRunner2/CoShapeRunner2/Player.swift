//
//  User.swift
//  CoShapeRunner2
//
//  Created by Tengis Gantulga on 6/6/18.
//  Copyright © 2018 Tengis Gantulga. All rights reserved.
//


import Foundation
import SpriteKit

class Player {
    
    var user = SKSpriteNode()
    
    var lane: Int = 1
    
    let duration = 0.25
    
    var randomColor: UInt32 = 0
    
    var lost: Bool = false
    
    init() {
        
    }
    
    init(user: SKSpriteNode) {
        self.user = user
        
        self.user.position.x = CGFloat(lane * 250 - 250)
        
        // 0 = YELLOW
        // 1 = RED
        // 2 = BLUE
        changeColor()
        
        
    }
    
    func update() {
        
    }
    
    func moveLeft() {
        if(lane > 0) {
            lane -= 1
            let moveLeft = SKAction.move(to: CGPoint(x: 250 * lane - 250, y: -500), duration: duration)
            user.run(moveLeft)
        }
    }
    
    func moveRight() {
        if(lane < 2) {
            lane += 1
            let moveRight = SKAction.move(to: CGPoint(x: 250 * lane - 250, y: -500), duration: duration)
            user.run(moveRight)
        }
    }
    
    func changeColor() {
        randomColor = arc4random_uniform(3)
        switch randomColor {
        case 0:
            user.color = UIColor.yellow
            break
        case 1:
            user.color = UIColor.red
            break
        case 2:
            user.color = UIColor.blue
            break
        default:
            user.color = UIColor.white
            break
        }
    }
    
    
    
}
