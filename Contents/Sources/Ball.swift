//
//  Ball.swift
//  ShootThemUp
//
//  Created by Pedro Velmovitsky on 14/03/17.
//  Copyright © 2017 velmovitsky. All rights reserved.
//

import Foundation
import SpriteKit

public class Ball {
    var spriteNode: SKSpriteNode!
    
    // Ball init setting image and z position
    public init(gameType: GameMode) {
        if (gameType == .Space) {
            spriteNode = SKSpriteNode(imageNamed: "laser")
        }
            
        else if (gameType == .Medieval) {
            
            spriteNode = SKSpriteNode(imageNamed: "fire")
        }
        spriteNode.zPosition = 2
    }
}

