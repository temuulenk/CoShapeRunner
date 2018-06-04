//
//  Player.swift
//  Testing
//
//  Created by Temuulen on 5/28/18.
//  Copyright © 2018 Temuulen. All rights reserved.
//

import Foundation
import SpriteKit

class Player {
    
    var x: Double = 0
    var y: Double = 0
    var radius: Double = 32
    var color: SKColor = SKColor.orange
    var circle: SKShapeNode = SKShapeNode()
    var index: Int = -1
    var name: String = ""
    
    var shouldMove: Bool = false
    var target: CGPoint = CGPoint()
    
    var speed: Double = 3.0
    
    init(x: Double, y: Double, index: Int) {
        self.x = x
        self.y = y
        self.index = index
        initializeCircle()
    }
    
    func update() {
        
        if(shouldMove == true) {
            let dx = Double(target.x) - self.x
            let dy = Double(target.y) - self.y
            let angle = atan2(dy, dx)
            
            let vx = cos(angle) * speed
            let vy = sin(angle) * speed
            
            self.x += vx
            self.y += vy
            
            self.circle.position = CGPoint(x: self.x, y: self.y)
            
            let distance = ((Double(target.x) - self.x) * (Double(target.x) - self.x) + (Double(target.y) - self.y) * (Double(target.y) - self.y)).squareRoot()
            
            if(distance <= 2) {
                shouldMove = false
            }
            
            
        }
        
//        self.x += 1
//        self.y += 1
//        self.circle.position = CGPoint(x: self.x, y: self.y)
    }
    
    func onTouch() {
        self.circle.fillColor = SKColor.red
    }
    
    func unselect() {
        self.circle.fillColor = SKColor.orange
    }
    
    func setTarget(target: CGPoint) {
    	self.target = target
        self.shouldMove = true
        print("SET TARGET")
    }
    
    
    func initializeCircle() {
        self.circle = SKShapeNode(circleOfRadius: CGFloat(radius))
        self.circle.position = CGPoint(x: self.x, y: self.y)
        self.circle.strokeColor = SKColor.black
        self.circle.glowWidth = 1.0
        self.circle.fillColor = self.color
        self.circle.name = String(index)
        self.name = self.circle.name!
    }
    
    
    
    
}

