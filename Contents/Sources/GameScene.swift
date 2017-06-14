//
//  GameScene.swift
//  Shoot Them Up
//
//  Created by Pedro Velmovitsky on 14/03/17.
//  Copyright © 2017 velmovitsky. All rights reserved.
//
import PlaygroundSupport
import SpriteKit
import GameplayKit
import AVFoundation


// GameScene class declaration
public class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // GameScene class variables
    var background: SKSpriteNode!
    var paddle: Paddle!
    var ball: Ball!
    var scoreLabel = SKLabelNode(fontNamed: "Arial Bold")
    let scoreHud = "scoreHud"
    var point: Int = 50
    var soundPlayed: ExplosionSound = .SuperSlapSound
    var backgroundSound : BackgroundMusic = .CarminaBurana
    var gameType: GameMode!
    var heroColor: PaddleColor!
    var fallingDuration: CGFloat!
    var newEnemyDuration: TimeInterval!
    var ballImpulse: CGFloat!
    var timer: Timer!
    var timerCount = 16
    var timerLabel = SKLabelNode(fontNamed: "Arial Bold")
    var gameOver: Bool = false
    
    // GameScene Init
    public init(type: GameMode, heroColor: PaddleColor, size: CGSize, duration: CGFloat, enemyDuration: TimeInterval, explosionSound: ExplosionSound, backgroundMusic: BackgroundMusic, ballImpulse: CGFloat) {
        super.init(size: size)
        
        self.gameType = type
        self.heroColor = heroColor
        self.fallingDuration = duration
        self.newEnemyDuration = enemyDuration
        self.soundPlayed = explosionSound
        self.backgroundSound = backgroundMusic
        self.ballImpulse = ballImpulse
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // didMove function to set the game with init parametes
    public override func didMove(to view: SKView) {
        
        setupGame(type: gameType, color: heroColor)
        
    }
    
    // Update function setup the paddle position and size
    public override func update(_ currentTime: TimeInterval) {
        if (paddle.spriteNode != nil) {
            paddle.spriteNode.size = CGSize(width: (self.background.size.width)/8, height: (self.background.size.height)/8)
            paddle.spriteNode.position = CGPoint(x: self.size.width/2, y: paddle.spriteNode.size.height / 2)
        }
    }
    
     // Setup ball function
    func setupBall(on paddle: Paddle) -> Ball {
        // Create a new ball
        let ball = Ball(gameType: gameType)
        
        // Set the ball's physics body and configurations
        let physicsBody = SKPhysicsBody(circleOfRadius: ball.spriteNode.size.height)
        physicsBody.categoryBitMask = PhysicsCategory.Ball
        physicsBody.contactTestBitMask = PhysicsCategory.Brick
        ball.spriteNode.physicsBody = physicsBody
        
        return ball
    }
    
    // Setup game function
    func setupGame(type: GameMode, color: PaddleColor) {
        
        // Timer configuration
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        // GameType and Hero Color setup
        gameType = type
        heroColor = color
        
        // Physics World setup
        physicsWorld.contactDelegate = self
        
        // Paddle (Spaceship at the bottom) configuration
        paddle = setupPaddle(mode: gameType, color: heroColor)
        
        
        // Background configuration
        if (gameType == .Space) {
            background = SKSpriteNode(imageNamed: "spaceBackgroundLandscape")
        }
        else if (gameType == .Medieval) {
            background = SKSpriteNode(imageNamed: "medievalBackgroundLandscape")
        }
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.size.height = self.size.height
        background.size.width = self.size.width
        self.addChild(background)
        
        // Background Music configuration
        var fileName: String?
        
        switch(backgroundSound) {
            
        case .HappyFunk:
            fileName = "HappyFunk.mp3"

        case .CarminaBurana:
            fileName = "CarminaBurana.mp3"
            
        case .SpaceGroove:
            fileName = "SpaceGroove.mp3"
            
        case .AdventureTune:
            fileName = "AdventureTune.mp3"
        


    }
        let backgroundMusic = SKAudioNode(fileNamed: fileName!)
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        addChild(paddle.spriteNode)
        
        // Setup Score Label
        setupHud(scoreLabel)
        
        // Setup Timer Label
        setupTimer(timerLabel)
        
        // Setup Enemies
        setupEnemies(fallingDuration: fallingDuration, newEnemyDuration: newEnemyDuration)
        
    }

    // Setup paddle function
    func setupPaddle(mode: GameMode, color: PaddleColor) -> Paddle {
        
        if (paddle != nil) {
            paddle.spriteNode.removeFromParent()
        }
        
        let hero = Paddle(gameScene:(self.view?.scene)!, gameType: gameType, color: heroColor)
        
        return hero
    }
    
    // Setup enemies function
    func setupEnemies(fallingDuration: CGFloat, newEnemyDuration: TimeInterval) {
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.setupBricks(fallingDuration: fallingDuration)
            }, SKAction.wait(forDuration: newEnemyDuration)
            ])
        ))
    }
    
    // Setup bricks function
    func setupBricks(fallingDuration: CGFloat) {
    
            // Create a new brick 
            let brick = Brick(gameScene: (self.view?.scene)!, gameType: gameType)
            brick.spriteNode.size = CGSize(width: (self.background.size.width)/15, height: (self.background.size.height)/14)
            
            // Configure actions (movements) of the brick
            let actionMove = SKAction.move(to: CGPoint(x: brick.spriteNode.position.x, y: paddle.spriteNode.size.height), duration: TimeInterval(fallingDuration))
            let actionMoveDone = SKAction.removeFromParent()
            let actionExplode = SKAction.run {
                if (!self.gameOver) {
                self.point -= 10
                self.textUpdate(self.scoreLabel)
                }
            }
    
            // Set the brick's physics body.
            let physicsBody = SKPhysicsBody(rectangleOf: brick.spriteNode.size)
            physicsBody.isDynamic = false
            physicsBody.categoryBitMask = PhysicsCategory.Brick
            physicsBody.collisionBitMask = PhysicsCategory.Ball
            brick.spriteNode.physicsBody = physicsBody
            
            brick.spriteNode.run(SKAction.repeatForever(SKAction.sequence([actionMove, actionMoveDone, actionExplode])))
            
            // Add brick
            scene?.addChild(brick.spriteNode)
        }
    
    // Setup background function
    func setupBackground(imageName: String) {
        
        background.removeFromParent()
        background = SKSpriteNode(imageNamed: imageName)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.size.height = self.size.height
        background.size.width = self.size.width
        background.alpha = 0.75
        addChild(background)
    }
    
    // Function to show image when timer is up
    func showImage() {
        gameOver = true
        let timeIsUp = SKSpriteNode(imageNamed: "TimeIsUp.png")
        timeIsUp.position = CGPoint(x: (self.background.size.width)/2, y: (self.background.size.height)/2)
        timeIsUp.zPosition = 10
        timeIsUp.size = CGSize(width: (self.frame.size.width / 1.2), height: (self.frame.size.height / 1.2))
        timeIsUp.alpha = 0.8
        self.addChild(timeIsUp)
    }
    
    // Function to update timerLabel value
    func updateTimer() {
        timerCount = timerCount - 1

        if (timerCount <= 0) {
            timerLabel.text = "Countdown: 0"
            showImage()
        }
        else {
            timerLabel.text = "Countdown: \(timerCount)"
        }
        
    }
    
    // Function to configure ball after the screen is touched
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            if (!gameOver) {
            // Call to setup ball
            ball = setupBall(on: paddle)
            
            // Choose one of the touches to work with
            guard let touch = touches.first else {
                return
            }
            let touchLocation = touch.location(in: self)
            
            // Set up initial location of projectile
            ball.spriteNode.position.x = paddle.spriteNode.position.x
            ball.spriteNode.position.y = paddle.spriteNode.position.y + paddle.spriteNode.size.height / 2
            ball.spriteNode.size = CGSize(width: (self.background.size.width)/20, height: (self.background.size.height)/20)
            
            // Determine offset of location to projectile
            let offset = touchLocation - ball.spriteNode.position
            
            // Bail out if you are shooting down or backwards
            //if (offset.y < paddle.spriteNode.size.height) { return }
            
            // OK to add now - you've double checked position
            addChild(ball.spriteNode)
            
            // Get the direction of where to shoot
            let direction = offset.normalized()
            
            // Make it shoot far enough to be guaranteed off screen
            let shootAmount = direction * self.size.height * ballImpulse
            
            // Add the shoot amount to the current position
            let realDest = shootAmount + ball.spriteNode.position
            
            // Create the actions
            let actionMove = SKAction.move(to: realDest, duration: 2.0)
            let actionLosePoints = SKAction.run {
                self.point -= 30
                self.textUpdate(self.scoreLabel)
            }
            let actionMoveDone = SKAction.removeFromParent()
            ball.spriteNode.run(SKAction.sequence([actionMove,actionMoveDone, actionLosePoints]))
            }
    }

    // Function to configure contact between bodies
    public func didBegin(_ contact: SKPhysicsContact) {
        
        // If esle statement checks if the bodies in touch are ball and enemy and respond accordingly
        if contact.bodyA.categoryBitMask == PhysicsCategory.Ball && contact.bodyB.categoryBitMask == PhysicsCategory.Brick   {
            explosion((contact.bodyB.node?.position)!)
            point += 50
            textUpdate(scoreLabel)
            contact.bodyB.node?.removeFromParent()
            contact.bodyA.node?.removeFromParent()
    }
        
        else if contact.bodyA.categoryBitMask == PhysicsCategory.Brick && contact.bodyB.categoryBitMask == PhysicsCategory.Ball   {
            explosion((contact.bodyA.node?.position)!)
            point += 50
            textUpdate(scoreLabel)
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
        }
    }
    
    // Function to configure the explosion effect
    func explosion(_ pos: CGPoint) {
        let emitterNode = SKEmitterNode(fileNamed: "ExplosionParticles.sks")
        emitterNode?.particlePosition = pos
        emitterNode?.zPosition = 2
       
        self.addChild(emitterNode!)
        self.run(SKAction.wait(forDuration: 0.1), completion: {
            emitterNode?.removeFromParent()
        })
        
        // Configuration of the explosion sound
        var fileName: String?
        
        switch(soundPlayed) {
        case .AwesomeExplosion:
            fileName = "AwesomeExplosion"
        case .WilhemScream:
            fileName = "WilhemScream"
        case .SuperSlapSound:
            fileName = "SuperSlapSound"
        }
        self.run(SKAction.playSoundFileNamed(fileName!, waitForCompletion: false))
    }
    
    // scoreLabel setup
    func setupHud(_ scoreLabel: SKLabelNode) {
        scoreLabel.name = scoreHud
        scoreLabel.fontSize = self.size.height / 30
        scoreLabel.zPosition = 4
        scoreLabel.text = String(format: "Score: %04u", 50)

        if (gameType == .Space) {
        scoreLabel.fontColor = UIColor.blueB
        }
        
        else if (gameType == .Medieval) {
            scoreLabel.fontColor = SKColor.redB
            
        }
        scoreLabel.position = CGPoint(x: scoreLabel.frame.size.width / 2 + 10 , y: scoreLabel.frame.size.height / 2)
        addChild(scoreLabel)

    }
    
    // timerLabel setup
    func setupTimer(_ timerLabel: SKLabelNode) {
        timerLabel.fontSize = self.size.height / 35
        timerLabel.zPosition = 4
        timerCount = timerCount - 1
        timerLabel.text = "Countdown \(timerCount)"
        
        if (gameType == .Space) {
            timerLabel.fontColor = UIColor.blueB
        }
            
        else if (gameType == .Medieval) {
            timerLabel.fontColor = SKColor.redB
            
        }
        timerLabel.position = CGPoint(x: self.background.frame.size.width - timerLabel.frame.size.width / 2 - 10, y: timerLabel.frame.size.height / 2)
        
        addChild(timerLabel)
    }
    
    // Function to update text of scoreLabel
    func textUpdate(_ scoreLabel: SKLabelNode) {
        if(point<0) { point=0}
        scoreLabel.text = String(format: "Score: %04u", point)
 
    }

}




