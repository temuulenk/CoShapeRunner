//
//  GameScene.swift
//  Testing
//
//  Created by Temuulen on 5/25/18.
//  Copyright © 2018 Temuulen. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    private var moveAmtX: CGFloat = 0
    private var moveAmtY: CGFloat = 0
    private let minimum_detect_distance: CGFloat = 100
    private var initialPosition: CGPoint = CGPoint.zero
    private var initialTouch: CGPoint = CGPoint.zero
    private var resettingSlider = false
    
    
    var user = SKSpriteNode()
    
    var nodes: [Obstacle] = []
    
    var lane: Int = 1
    
    let duration = 0.25
    
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        user = self.childNode(withName: "user") as! SKSpriteNode
        
		user.position.x = CGFloat(lane * 250 - 250)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(3), target:self, selector:#selector(GameScene.createNodes), userInfo:nil, repeats: true)
        
		user.color = UIColor.brown
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first as UITouch! {
            initialTouch = touch.location(in: self.scene!.view)
            moveAmtY = 0
            moveAmtX = 0
            initialPosition = self.position
        }
        
    	
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            let movingPoint: CGPoint = touch.location(in: self.scene!.view)
            moveAmtX = movingPoint.x - initialTouch.x
            moveAmtY = movingPoint.y - initialTouch.y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if fabs(moveAmtX) > minimum_detect_distance {
            
            //must be moving side to side
            if moveAmtX < 0 {
                moveLanes(direction: 0)
            }
            else {
                moveLanes(direction: 1)
            }
        }
//        else if fabs(moveAmtY) > minimum_detect_distance {
//
//            //must be moving up and down
//            if moveAmtY < 0 {
//                direction = "up"
//            }
//            else {
//                direction = "down"
//            }
//        }
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        for n in nodes {
            n.update()
        }
        
    }
    
    @objc func createNodes() {
//        let node = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
//        node.strokeColor = SKColor.yellow
//        node.fillColor = SKColor.yellow
//        node.alpha = 1
//        node.name = "node"
//
//        let random = arc4random_uniform(3);
//        print(random)
//
//        node.position.x = CGFloat(250 * Float(random) - 250)
//        node.position.y = 700
//        node.zPosition = 10
//        addChild(node)
        
        let obstacle = Obstacle()
        nodes.append(obstacle)
        addChild(obstacle.getNode())
        
        
    }
    
//    func moveStars(){
//        enumerateChildNodes(withName: "node", using: { (star, stop) in
//            let strip = star as! SKShapeNode
//            strip.position.y -= 15
//        })
//    }
    
    
    func moveLanes(direction: Int) {
        if(direction == 0) {
            self.lane -= 1
            let moveLeft = SKAction.move(to: CGPoint(x: 250 * lane - 250, y: -500), duration: duration)
            user.run(moveLeft)
        }else if(direction == 1) {
            self.lane += 1
            let moveRight = SKAction.move(to: CGPoint(x: 250 * lane - 250, y: -500), duration: duration)
            user.run(moveRight)
        }
    }
    
    
    
    
    
    
    
    
}
