//
//  GameScene.swift
//  Game
//
//  Created by Temuulen on 6/10/18.
//  Copyright © 2018 Temuulen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //
    private var moveAmountX: CGFloat = 0
    private var moveAmountY: CGFloat = 0
    private let minimum_detect_distance: CGFloat = 100
    private var initialPosition: CGPoint = CGPoint.zero
    private var initialTouch: CGPoint = CGPoint.zero
    private var resettingSlider = false
    //
    
    
    private var player : Player?
    
    private var nodes: [Obstacle] = []
    
    private var currentWave: Int = 0
    
    
    override func didMove(to view: SKView) {
        print("Hello, world")
        
        player = Player(player: (self.childNode(withName: "player") as? SKSpriteNode)!)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(2.5), target:self, selector:#selector(GameScene.createNodes), userInfo:nil, repeats: true)
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            initialTouch = touch.location(in: self.scene!.view)
            moveAmountX = 0
            moveAmountY = 0
            initialPosition = self.position
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let movingPoint: CGPoint = touch.location(in: self.scene!.view)
            moveAmountX = movingPoint.x - initialTouch.x
            moveAmountY = movingPoint.y - initialTouch.y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if fabs(moveAmountX) > minimum_detect_distance {
            if(moveAmountX < 0) {
                player?.moveLanes(direction: 0)
            }else {
                player?.moveLanes(direction: 1)
            }
        }
    }
	
    override func update(_ currentTime: TimeInterval) {
        for node in nodes {
            if(node.getNode().position.y <= (player?.getNode().position.y)! && node.lane == player?.lane && node.currentColor == player?.currentColor) {
                node.getNode().removeFromParent()
                player?.changeColor()
            }
            node.update()
        }
    }
	
    
    @objc func createNodes() {
        for i in 0...3 {
            let obstacle = Obstacle(player: player!, lane: i, currentWave: currentWave)
            nodes.append(obstacle)
            addChild(obstacle.getNode())
        }
        self.currentWave += 1
    }


}
