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
    
    var user = SKSpriteNode()
    
    var lane: Int = 1
    
    //
    private var moveAmountX: CGFloat = 0
    private var moveAmountY: CGFloat = 0
    private let minimum_detect_distance: CGFloat = 100
    private var initialPosition: CGPoint = CGPoint.zero
    private var initialTouch: CGPoint = CGPoint.zero
    private var resettingSlider = false
    //
    
    let duration = 0.25
    
    
    //the main part that shows the running code
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setUp()
        user = self.childNode(withName: "user") as! SKSpriteNode
        createRoad()
        Timer.scheduledTimer(timeInterval: TimeInterval(0.3), target:self, selector:#selector(GameScene.createRoad), userInfo:nil, repeats: true)
        
        user.position.x = CGFloat(lane * 250 - 250)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveStars()
    }
    
    //setting up
    func setUp(){
        user = self.childNode(withName: "user") as! SKSpriteNode
    }
    
    //creating the stars on the side
    @objc func createRoad(){
        let leftStar = SKShapeNode(rectOf: CGSize(width: 10, height: 20))
        //outline color
        leftStar.strokeColor = SKColor.yellow
        //completely fill in the shape
        leftStar.fillColor = SKColor.yellow
        //brightness
        leftStar.alpha = 1
        //naming it
        leftStar.name = "leftStar"
        //setting the position of the star
        leftStar.position.x = -340
        leftStar.position.y = 700
        //z position is the "overlay." Basically if an item has a higher z position than another, and if those two items are on top of each other, the item with higher z position will be shown above it.
        leftStar.zPosition = 10
        addChild(leftStar)
        
        let rightStar = SKShapeNode(rectOf: CGSize(width: 10, height: 20))
        rightStar.strokeColor = SKColor.yellow
        rightStar.fillColor = SKColor.yellow
        rightStar.alpha = 1
        rightStar.name = "rightStar"
        rightStar.position.x = 340
        rightStar.position.y = 700
        rightStar.zPosition = 10
        addChild(rightStar)
    }
    //moves the stars on the side
    func moveStars(){
        enumerateChildNodes(withName: "leftStar", using: { (star, stop) in
            let strip = star as! SKShapeNode
            //decrease the position downwards
            strip.position.y -= 15
        })
        //same thing as above but with right stars
        enumerateChildNodes(withName: "rightStar", using: { (star, stop) in
            let strip = star as! SKShapeNode
            strip.position.y -= 15
        })
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
            print(moveAmountX)
            if(moveAmountX < 0) {
                // left
                print("LEFT")
                moveLanes(direction: 0)
            }else {
                // right
                print("RIGHT")
                moveLanes(direction: 1)
            }
        }
    }
    
    func moveLanes(direction: Int) {
        // 0 -> left
        // 0 -> right
        if(direction == 0 && lane > 0) {
            self.lane -= 1
//            user.position.x = CGFloat(250 * lane - 250)
            let moveLeft = SKAction.move(to: CGPoint(x: 250 * lane - 250, y: -500), duration: duration)
            user.run(moveLeft)
        }else if(direction == 1 && lane < 2) {
            self.lane += 1
//            user.position.x = CGFloat(250 * lane - 250)
            let moveRight = SKAction.move(to: CGPoint(x: 250 * lane - 250, y: -500), duration: duration)
            user.run(moveRight)
        }
        
    }
    
    
    
}
