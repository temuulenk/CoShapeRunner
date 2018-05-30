//
//  GameScene.swift
//  CoShapeRunner
//
//  Created by Tengis Gantulga on 5/24/18.
//  Copyright © 2018 Tengis Gantulga. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var rainbow = SKSpriteNode()
    var x: Double = 0
    
    override func didMove(to view: SKView) {
        rainbow = SKSpriteNode(imageNamed: "cube")
        rainbow.position = CGPoint(x: 100, y: 100)
        self.addChild(rainbow)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            print(touch.location(in: self).x)
            rainbow.position = CGPoint(x: touch.location(in: self).x, y: touch.location(in: self).y)
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        rainbow.position = CGPoint(x:100, y:CGFloat(x))
        x += 1
        
    }
    
    
}
