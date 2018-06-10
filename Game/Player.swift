//
//  Player.swift
//  Game
//
//  Created by Temuulen on 6/10/18.
//  Copyright © 2018 Temuulen. All rights reserved.
//

import Foundation
import SpriteKit

class Player {
    
    var player : SKSpriteNode?
    
    var lane: Int = 1
    
    let animationDuration = 0.25
    
    var currentColor: Color?
    
    private var currentWave: Int = 0
    
    
    init(player: SKSpriteNode) {
        self.player = player
        
        self.player?.physicsBody = SKPhysicsBody(rectangleOf: (self.player?.size)!)
        self.player?.physicsBody?.affectedByGravity = false
        self.player?.physicsBody?.isDynamic = false
        self.player?.physicsBody?.categoryBitMask = 0
        
        self.changeToRandomColor()
        player.color = (currentColor?.getColor())!
        
    }
    
    func pulsate() {
        let pulse = SKAction.sequence([SKAction.scale(to: 1.2, duration: animationDuration), SKAction.scale(to: 1, duration: animationDuration)])
        player?.run(pulse)
//        player?.run(SKAction.repeatForever(pulse))
    }
    
    
    // MOVEMENT FUNCTIONS
    func moveLanes(direction: Int) {
        if(direction == 0 && self.lane > 0) {
            player?.run(SKAction.sequence([SKAction.group([SKAction.rotate(byAngle: +1.5708, duration: animationDuration), SKAction.move(to: CGPoint(x: 250 * (lane - 1) - 250, y: -500), duration: animationDuration)]), SKAction.run({
                self.lane -= 1
                print("FINISHED CHANGING TO LANE: \(self.lane)")
            })]))
        }
        else if(direction == 1 && self.lane < 2) {
            player?.run(SKAction.sequence([SKAction.group([SKAction.rotate(byAngle: -1.5708, duration: animationDuration), SKAction.move(to: CGPoint(x: 250 * (lane + 1) - 250, y: -500), duration: animationDuration)]), SKAction.run({
                self.lane += 1
                print("FINISHED CHANGING TO LANE: \(self.lane)")
            })]))
        }
    }
    
    
    // CHANGING COLORS
    func changeColorAction() -> SKAction {
        changeToRandomColor()
        return SKAction.colorize(with: (currentColor?.getColor())!, colorBlendFactor: 1, duration: animationDuration)
    }
    
    func changeColor() {
        changeToRandomColor()
        self.player?.run(SKAction.colorize(with: (currentColor?.getColor())!, colorBlendFactor: 0, duration: animationDuration))
    }
    
    func changeToRandomColor() {
        let random = arc4random_uniform(3)
        if(random == 0) {
            self.currentColor = Color.Red
        }else if(random == 1) {
            self.currentColor = Color.Blue
        }else {
            self.currentColor = Color.Yellow
        }
        self.currentWave += 1
    }

    func getNode() -> SKSpriteNode {
        return player!
    }
    
}


