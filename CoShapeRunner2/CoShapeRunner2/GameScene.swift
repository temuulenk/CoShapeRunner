//
//  GameScene.swift
//  CoShapeRunner2
//
//  Created by Tengis Gantulga on 5/29/18.
//  Copyright © 2018 Tengis Gantulga. All rights reserved.
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
    
    
    //    var user = SKSpriteNode()
    
    var nodes: [Obstacle] = []
    
    var lane: Int = 1
    
    let duration = 0.25
    
    var player: Player = Player()
    
    static var timer : Timer?
    
    static var lost: Bool = false
    
    static var currentWave: Int = 0
    var currentWave1: Int = 0
    
    static var score: SKLabelNode = SKLabelNode()
    static var endscreen: SKLabelNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        player = Player(user: self.childNode(withName: "user") as! SKSpriteNode)
        GameScene.score = childNode(withName: "score") as! SKLabelNode
        GameScene.endscreen = childNode(withName: "endscreen") as! SKLabelNode
        
//        GameScene.timer = Timer.scheduledTimer(timeInterval: TimeInterval(3), target:self, selector:#selector(GameScene.createNodes), userInfo:nil, repeats: true)
        

        
        //        user.color = UIColor.brown
        //
        //        user.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height:100))
        //        user.physicsBody?.isDynamic = true
        //        user.physicsBody?.affectedByGravity = false
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(GameScene.lost) {
            restart()
        }
        if let touch = touches.first as UITouch? {
            initialTouch = touch.location(in: self.scene!.view)
            moveAmtY = 0
            moveAmtX = 0
            initialPosition = self.position
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let movingPoint: CGPoint = touch.location(in: self.scene!.view)
            moveAmtX = movingPoint.x - initialTouch.x
            moveAmtY = movingPoint.y - initialTouch.y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if fabs(moveAmtX) > minimum_detect_distance {
            
            //must be moving side to side
            if moveAmtX < 0 {
                //                moveLanes(direction: 0)
                player.moveLeft()
            }
            else {
                //                moveLanes(direction: 1)
                player.moveRight()
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
    
    var t: Double = 0
    static var remainder: Double = 2
    
    override func update(_ currentTime: TimeInterval) {
        
        if(!GameScene.lost) {
            t += currentTime
            
            if((t / 10000000) >= GameScene.remainder) {
                createNodes()
                t = 0
                currentWave1 += 1
            }
            
            for n in nodes {
                if(n.toRemove) {
                    n.getNode().removeFromParent()
                }else {
                    n.update()
                }
            }
        }
        
    }
    
    @objc func createNodes() {
        var colors: [Int] = [0, 1, 2]
        var lanes: [Int] = [0, 1, 2]
        
        for _ in 0...2 {
            let randomColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
            let color = colors[randomColorIndex]
            colors.remove(at: randomColorIndex)
            
            let randomLaneIndex = Int(arc4random_uniform(UInt32(lanes.count)))
            let lane = lanes[randomLaneIndex]
            lanes.remove(at: randomLaneIndex)
            
            let obstacle = Obstacle(lane: lane, randomColor: color, player: player, currentWave1: currentWave1)
            nodes.append(obstacle)
            addChild(obstacle.getNode())
        }
    }
    
    
    
//    @objc func createNodes() {
//                //let node = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
//                //node.strokeColor = SKColor.yellow
//                //node.fillColor = SKColor.yellow
//                //node.alpha = 1
//                //node.name = "node"
//
//                let random = arc4random_uniform(3);
//                print(random)
//
//                node.position.x = CGFloat(250 * Float(random) - 250)
//                node.position.y = 700
//                node.zPosition = 10
//                addChild(node)
//
//        let obstacle = Obstacle(player: player)
//        nodes.append(obstacle)
//        addChild(obstacle.getNode())
//
//
//    }
//
//        func moveStars(){
//            enumerateChildNodes(withName: "node", using: { (star, stop) in
//                let strip = star as! SKShapeNode
//                strip.position.y -= 15
//            })
//        }
//
    
    func moveLanes(direction: Int) {
        if(direction == 0) {
            self.lane -= 1
            _ = SKAction.move(to: CGPoint(x: 250 * lane - 250, y: -500), duration: duration)
            //            user.run(moveLeft)
        }else if(direction == 1) {
            self.lane += 1
            _ = SKAction.move(to: CGPoint(x: 250 * lane - 250, y: -500), duration: duration)
            //            user.run(moveRight)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("HELLO")
    }
    
    
    static func onLost() {
        GameScene.lost = true
        GameScene.endscreen.alpha = 1
    }
    
    func restart() {
        GameScene.lost = false
        GameScene.endscreen.alpha = 0
        t = 0
        GameScene.remainder = 2.0
        GameScene.score.text = "0"
        GameScene.currentWave = 0
        currentWave1 = 0
        for n in nodes {
            n.getNode().removeFromParent()
        }
    }
    
    
    
    
}

