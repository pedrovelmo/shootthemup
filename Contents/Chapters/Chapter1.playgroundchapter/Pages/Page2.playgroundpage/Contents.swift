
/*:
 
 **Challenge:** Configure your game bellow: choose the storyline mode and customize your hero, the force of the shot, the movement of the enemies and the sound effects. If you have any difficulties, check the *Hint* button for more information. Try out different combinations, press the Run My Code button and have fun!

- **Note:** **Remember, for each enemy that hits you, you lose 10 points, and for each shot that goes offscreen, you lose 30 points!**
 
 
 */
//#-hidden-code
import UIKit
import PlaygroundSupport
import SpriteKit

// Inner View declaration as GameViewController
let innerView = GameViewController(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
innerView.clipsToBounds = true
innerView.translatesAutoresizingMaskIntoConstraints = false

// Live View declaration
let liveView = MyLiveView()
liveView.backgroundColor = UIColor.clear

liveView.addSubview(innerView)

// Inner View constraints setup
let centerX = innerView.centerXAnchor.constraint(equalTo: liveView.centerXAnchor)
centerX.priority = UILayoutPriorityRequired
let centerY = innerView.centerYAnchor.constraint(equalTo: liveView.centerYAnchor)
centerY.priority = UILayoutPriorityRequired
let aspectRatio = innerView.widthAnchor.constraint(equalTo: innerView.heightAnchor, multiplier: 1.5)
aspectRatio.priority = UILayoutPriorityRequired
let lessThanOrEqualWidth = innerView.widthAnchor.constraint(lessThanOrEqualTo: liveView.widthAnchor)
lessThanOrEqualWidth.priority = UILayoutPriorityRequired
let lessThanOrEqualHeight = innerView.widthAnchor.constraint(lessThanOrEqualTo: liveView.heightAnchor)
lessThanOrEqualHeight.priority = UILayoutPriorityRequired

let equalWidth = innerView.widthAnchor.constraint(equalTo: liveView.widthAnchor)
equalWidth.priority = UILayoutPriorityDefaultHigh
let equalHeight = innerView.heightAnchor.constraint(equalTo: liveView.heightAnchor)
equalHeight.priority = UILayoutPriorityDefaultHigh

NSLayoutConstraint.activate([
    centerX,
    centerY,
    aspectRatio,
    lessThanOrEqualWidth,
    lessThanOrEqualHeight,
    equalWidth,
    equalHeight
    ])

// Setuo of current page live view
let page = PlaygroundPage.current
page.liveView = liveView
page.needsIndefiniteExecution = true

// Functions to be called when the user edit the text and run code
var gameMode: GameMode!
var gameColor: PaddleColor!
var ballForce = CGFloat()
var duration = CGFloat()
var enemyDuration = TimeInterval()


private func setupGame(storyline: GameMode, heroColor: PaddleColor, shotImpulsePower: CGFloat) {
    
    // Configure game mode, game color and ball force
    gameMode = storyline
    gameColor = heroColor
    ballForce = shotImpulsePower / 10
    if (ballForce <= 0) {
        ballForce = 0.05
        
    }
}

private func setupEnemies(fallingDuration: CGFloat, enemySpawnTime: TimeInterval) {
    
    // Configure enemy movement duration and spawn time
    var assignDuration: CGFloat = fallingDuration
    var assignEnemyDuration: TimeInterval = enemySpawnTime
    if (fallingDuration <= 0.06) {
        
        assignDuration = 0.05
    }
    
    if (enemySpawnTime <= 0.06) {
        
        assignEnemyDuration = 0.05
    }
    
    duration = assignDuration
    enemyDuration = assignEnemyDuration
    
}

private func setupAudio(enemyExplosionSound: ExplosionSound, backgroundMusic: BackgroundMusic) {
    
    // Setup scene with parameters typed by the user
    let newScene = GameScene(type: gameMode, heroColor: gameColor, size: innerView.frame.size, duration: duration, enemyDuration: enemyDuration, explosionSound: enemyExplosionSound, backgroundMusic: backgroundMusic, ballImpulse: ballForce)
    
    innerView.setupScene(scene: newScene)
    
}
//#-end-hidden-code
//#-code-completion(everything, show, .Medieval, .Space, .Red, .Blue, .Yellow, .Green, .Purple, SuperSlapSound, WilhemScream, AwesomeExplosion, CarminaBurana.mp3, AdventureTune.mp3, SpaceGroove.mp3, HappyFunk.mp3)
//Configure the storyline mode, color of the hero and force of the shot
setupGame(storyline:/*#-editable-code */.Medieval/*#-end-editable-code*/, heroColor: /*#-editable-code */.Green/*#-end-editable-code*/, shotImpulsePower:/*#-editable-code*/20.0/*#-end-editable-code*/)

//Configure the enemies movement duration and spawn time
setupEnemies(fallingDuration:/*#-editable-code */3.0/*#-end-editable-code*/, enemySpawnTime: /*#-editable-code */1.0/*#-end-editable-code*/)

//Configure the explosion sound and the background music
setupAudio(enemyExplosionSound:/*#-editable-code */.SuperSlapSound/*#-end-editable-code*/, backgroundMusic: /*#-editable-code */.CarminaBurana/*#-end-editable-code*/)




