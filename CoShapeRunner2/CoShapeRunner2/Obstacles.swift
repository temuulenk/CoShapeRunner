//
//  Obstacles.swift
//  CoShapeRunner2
//
//  Created by Tengis Gantulga on 6/6/18.
//  Copyright © 2018 Tengis Gantulga. All rights reserved.
//
import Foundation
import SpriteKit

class Obstacle {
    
    var node: SKShapeNode = SKShapeNode()
    
    let size = 50
    
    var randomColor: Int = 0
    
    var player: Player = Player()
    
    var lane: Int = 0
    
    var toRemove: Bool = false
    var currentWave1: Int = 0
    
    
    init(lane: Int, randomColor: Int, player: Player, currentWave1: Int) {
        self.lane = lane
        self.randomColor = randomColor
        self.player = player
        self .currentWave1 = currentWave1
        
        node = SKShapeNode(rectOf: CGSize(width: size, height: size))
        
//        randomColor = Int(arc4random_uniform(3))
        if(randomColor == 0) {
            node.strokeColor = SKColor.white
            node.fillColor = SKColor.yellow
        }else if(randomColor == 1) {
            node.strokeColor = SKColor.white
            node.fillColor = SKColor.red
        }else {
            node.strokeColor = SKColor.white
            node.fillColor = SKColor.blue
        }
        
        node.alpha = 1
        node.name = "node"
        
        
        
        node.position.x = CGFloat(250 * Float(lane) - 250)
        node.position.y = 700
        node.zPosition = 10
    }
    
    func update() {
        node.position.y -= 15
        if(GameScene.currentWave == self.currentWave1) {
            if(self.lane == player.lane && node.position.y <= CGFloat(-450) && Int(player.randomColor) == self.randomColor) {
                GameScene.currentWave += 1
                print("MATCHES")
                player.changeColor()
                toRemove = true
                GameScene.score.text = String(self.currentWave1 + 1)
                if(GameScene.remainder > 0.4) {
                    GameScene.remainder -= 0.1
                }
            }else if(self.lane == player.lane && node.position.y <= CGFloat(-450) && Int(player.randomColor) != self.randomColor) {
                print("DOESNT MATCH")
                GameScene.onLost()
                toRemove = true
            }
            else if(self.lane != player.lane) {
                if(node.position.y < CGFloat(-750)) {
                    print("REMOVING")
                    toRemove = true
                }
            }
        }
//        if(node.position.y <= CGFloat(-450 - size)) {
//            if(player.lane == self.lane && Int(player.randomColor) == self.randomColor) {
//                print("MATCHES")
//                print(GameScene.remainder)
//                player.changeColor()
//                toRemove = true
//                if(GameScene.remainder > 0.4){
//                    GameScene.remainder -= 0.1
//                }
//            }else if(player.lane == self.lane && Int(player.randomColor) != self.randomColor) {
//                print("LOST")
//                GameScene.onLost()
//                toRemove = true
//            }else {
//                toRemove = true
//            }
//        }
    }
    
    func getNode() -> SKShapeNode {
        return node
    }
    
    
    
}
