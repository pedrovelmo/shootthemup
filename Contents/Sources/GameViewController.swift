import UIKit
import SpriteKit
import GameplayKit
import PlaygroundSupport


public class GameViewController: SKView, PlaygroundLiveViewSafeAreaContainer {

    // GameViewController setup
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.showsFPS = false
        self.showsNodeCount = false
 
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Function to present scene
    public func setupScene(scene: GameScene) {
    
    self.presentScene(scene)
    
    
    }
}

