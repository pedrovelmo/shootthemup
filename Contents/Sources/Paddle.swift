//
//  Paddle.swift
//  ShootThemUp
//
//  Created by Pedro Velmovitsky on 14/03/17.
//  Copyright © 2017 velmovitsky. All rights reserved.
//

import Foundation
import SpriteKit

public class Paddle {
    var spriteNode: SKSpriteNode!
    var gameScene: SKScene

    // Paddle init setting overall position and image
    public init(gameScene: SKScene, gameType: GameMode, color: PaddleColor) {
        
        self.gameScene = gameScene
        if (gameType == .Space) {
            
            switch(color) {
                
            case .Red:
                spriteNode = SKSpriteNode(imageNamed: "spaceship_red")
            case .Yellow:
                spriteNode = SKSpriteNode(imageNamed: "spaceship_yellow")
            case .Blue:
                spriteNode = SKSpriteNode(imageNamed: "spaceship_blue")
            case .Purple:
                spriteNode = SKSpriteNode(imageNamed: "spaceship_purple")
            case .Green:
                spriteNode = SKSpriteNode(imageNamed: "spaceship_green")
            }
        }
            
        else if (gameType == .Medieval) {
            
            switch(color) {
                
            case .Red:
                spriteNode = SKSpriteNode(imageNamed: "dragon_red")
            case .Yellow:
                spriteNode = SKSpriteNode(imageNamed: "dragon_yellow")
            case .Blue:
                spriteNode = SKSpriteNode(imageNamed: "dragon_blue")
            case .Purple:
                spriteNode = SKSpriteNode(imageNamed: "dragon_purple")
            case .Green:
                spriteNode = SKSpriteNode(imageNamed: "dragon_green")
            }
        }
        spriteNode.position = CGPoint(x: gameScene.size.width/2, y: spriteNode.size.height / 2)
        spriteNode.alpha = 0.85
        spriteNode.zPosition = 3
    }
}
