//
//  Vector.swift
//  Testing
//
//  Created by Temuulen on 5/25/18.
//  Copyright © 2018 Temuulen. All rights reserved.
//

import Foundation


class Vector {
    
    var x: Double = 0
    var y: Double = 0
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    init() {
        self.x = 0
        self.y = 0
    }
    
    func add(vector: Vector) {
        self.x += vector.getX()
        self.y += vector.getY()
    }
    
    func subtract(vector: Vector) -> Vector {
        self.x -= vector.getX()
        self.y -= vector.getY()
        return self
    }
    
    func multiply(vector: Vector) {
        self.x *= vector.getX()
        self.y *= vector.getY()
    }
    
    func divide(scalar: Double) -> Vector {
        self.x /= scalar
        self.y /= scalar
        return self
    }
    
//    func / (vector: Vector, scalar: Double) -> Vector {
//        return Vector(x: vector.getX() / scalar, y: vector.getY() / scalar)
//    }
    
//    func / (vector: CGPoint, scalar: CGFloat) -> CGPoint
//    {
//        return CGPoint(x: vector.x / scalar, y: vector.y / scalar)
//    }
    
    func scale(scale: Double) -> Vector {
        self.x *= scale
        self.y *= scale
        return self
    }
    
    func magnitude() -> Double {
        return (x * x + y * y).squareRoot()
    }
    
    func lengthSquared() -> Double {
        return x * x + y * y
    }
    
    func length() -> Double {
        return magnitude()
    }
    
    func normalize() -> Vector {
		let lengthSquared = self.lengthSquared()
        return self.divide(scalar: sqrt(lengthSquared))
    }
    
    func setMagnitude(magnitude: Double) {
        normalize()
        self.scale(scale: magnitude)
    }
    
    
    func getX() -> Double {
        return self.x
    }
    
    func getY() -> Double {
        return self.y
    }
    
    
}
