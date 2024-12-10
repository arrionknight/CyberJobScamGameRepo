import SpriteKit

class GameOverScene: SKScene {
    
    var score: Int = 0
    var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        setupGameOverText()
        setupScoreLabels()
        setupButtons()
    }
    
    private func setupGameOverText() {
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontName = "AvenirNext-Bold"
        gameOverLabel.fontSize = 48
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        addChild(gameOverLabel)
    }
    
    private func setupScoreLabels() {
        // Score Label
        let scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = .black
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.5)
        addChild(scoreLabel)
        
        // High Score Label
        let highScoreLabel = SKLabelNode(text: "High Score: \(highScore)")
        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontSize = 24
        highScoreLabel.fontColor = .black
        highScoreLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.4)
        addChild(highScoreLabel)
    }
    
    private func setupButtons() {
        // Menu Button
        let menuButton = SKLabelNode(text: "Menu")
        menuButton.fontName = "AvenirNext-Bold"
        menuButton.fontSize = 24
        menuButton.fontColor = .blue
        menuButton.position = CGPoint(x: size.width / 2 - 50, y: size.height * 0.3)
        menuButton.name = "menuButton"
        addChild(menuButton)
        
        // Replay Button
        let replayButton = SKLabelNode(text: "Play Again")
        replayButton.fontName = "AvenirNext-Bold"
        replayButton.fontSize = 24
        replayButton.fontColor = .blue
        replayButton.position = CGPoint(x: size.width / 2 + 50, y: size.height * 0.3)
        replayButton.name = "replayButton"
        addChild(replayButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let node = atPoint(location) as? SKLabelNode {
            if node.name == "menuButton" {
                // Go back to the main menu
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene)
                }
            } else if node.name == "replayButton" {
                // Restart the game
                if let scene = PlayGameScene(fileNamed: "PlayGameScene") {
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene)
                }
            }
        }
    }
}
