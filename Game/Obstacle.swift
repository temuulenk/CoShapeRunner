//
//  Obstacle.swift
//  Game
//
//  Created by Temuulen on 6/10/18.
//  Copyright © 2018 Temuulen. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacle {
    
    var node: SKSpriteNode?
    let size = 60
    
    var currentColor: Color?
    
    var player: Player?
    
    var lane: Int = 0
    var currentWave: Int = 0
    
    var ignoreCollisions: Bool = false
    
    init(player: Player, lane: Int, currentWave: Int) {
        self.player = player
        self.lane = lane
        self.currentWave = currentWave
//        node = SKSpriteNode(rectOf: CGSize(width: size, height: size))
        node = SKSpriteNode()
        node?.size = CGSize(width: size, height: size)
        changeToLane()
		
        
        // TESTING
        changeToRandomColor()
        node?.color = (currentColor?.getColor())!
    
        
        self.node?.physicsBody = SKPhysicsBody(rectangleOf: (self.node?.size)!)
        self.node?.physicsBody?.affectedByGravity = false
        self.node?.physicsBody?.isDynamic = false
        
        
        
    }
    
    func update() {
        node?.position.y -= 15
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
    }
    
    func changeToLane() {
        node?.position.x = CGFloat(250 * lane - 250)
        node?.position.y = CGFloat(700)
    }
    
    func ignoreCollision() {
        self.ignoreCollisions = true
    }
    
    func getNode() -> SKSpriteNode {
        return node!
    }
    
    
}


