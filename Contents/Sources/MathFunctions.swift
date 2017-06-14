//
//  MathFunctions.swift
//  WWDCGameTest
//
//  Created by Pedro Velmovitsky on 14/03/17.
//  Copyright © 2017 velmovitsky. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

// Auxiliary Math Functions for geometry calculations
public func createInitPosition(node: SKSpriteNode, viewSize:CGSize)->CGPoint {

    return CGPoint(x: randomAux(min: node.size.width, max: viewSize.width - node.size.width / 2), y: viewSize.height + node.size.height / 2)
    
}

public func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

public func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}


public func randomAux(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}
