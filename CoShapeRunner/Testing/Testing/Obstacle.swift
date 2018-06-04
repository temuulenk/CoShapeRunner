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
    
    init() {
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
        
        let random = arc4random_uniform(3);
        print(random)
        
        node.position.x = CGFloat(250 * Float(random) - 250)
        node.position.y = 700
        node.zPosition = 10
    }
    
    func update() {
        node.position.y -= 15
    }
    
    func getNode() -> SKShapeNode {
        return node
    }
    
    
    
}

