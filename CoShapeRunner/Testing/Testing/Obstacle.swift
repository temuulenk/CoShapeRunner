//
//  Obstacle.swift
//  Testing
//
//  Created by Temuulen on 6/4/18.
//  Copyright © 2018 Temuulen. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacle {
    
    var node: SKShapeNode = SKShapeNode()
    
    let size = 30
    
    var randomColor: Int = 0

    var player: Player = Player()
    
    var lane: UInt32 = 0
    
    var toRemove: Bool = false
    
    init(player: Player) {
        self.player = player
        
        node = SKShapeNode(rectOf: CGSize(width: size, height: size))
        
        randomColor = Int(arc4random_uniform(3))
        if(randomColor == 0) {
            node.strokeColor = SKColor.yellow
            node.fillColor = SKColor.yellow
        }else if(randomColor == 1) {
            node.strokeColor = SKColor.red
            node.fillColor = SKColor.red
        }else {
            node.strokeColor = SKColor.blue
            node.fillColor = SKColor.blue
        }
        
        node.alpha = 1
        node.name = "node"
        
        lane = arc4random_uniform(3);
        
        node.position.x = CGFloat(250 * Float(lane) - 250)
        node.position.y = 700
        node.zPosition = 10
    }
    
    func update() {
        node.position.y -= 15
        if(node.position.y <= CGFloat(-500 - size)) {
            if(player.lane == self.lane && Int(player.randomColor) == self.randomColor) {
                print("MATCHES")
        		player.changeColor()
                toRemove = true
            }else if(player.lane == self.lane && Int(player.randomColor) != self.randomColor) {
                print("LOST")
                GameScene.onLost()
             	toRemove = true
            }else {
                toRemove = true
            }
        }
    }
    
    func getNode() -> SKShapeNode {
        return node
    }
    
    
    
}

