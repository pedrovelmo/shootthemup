//
//  Brick.swift
//  ShootThemUp
//
//  Created by Pedro Velmovitsky on 14/03/17.
//  Copyright © 2017 velmovitsky. All rights reserved.
//

import Foundation
import SpriteKit


public class Brick  {
    
    var spriteNode: SKSpriteNode!
    var gameScene: SKScene
    
    // Brick init setting overall position and image
    init(gameScene: SKScene, gameType: GameMode) {
        self.gameScene = gameScene
        
        if (gameType == .Space) {
            spriteNode = SKSpriteNode(imageNamed: "Asteroid")
        }
            
        else if (gameType == .Medieval) {
            
            spriteNode = SKSpriteNode(imageNamed: "skeleton")
        }
        spriteNode.position = createInitPosition(node: self.spriteNode, viewSize: gameScene.size)
        spriteNode.zPosition = 2
    }
    
    
    
}
