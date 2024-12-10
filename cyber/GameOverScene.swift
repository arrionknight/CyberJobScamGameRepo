import SpriteKit

class GameOverScene: SKScene {
    var finalScore: Int = 0
    var highScore: Int = 0

    override func didMove(to view: SKView) {
        backgroundColor = .white

        // Display final score
        let scoreLabel = SKLabelNode(text: "Your Score: \(finalScore)")
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = .black
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.6)
        addChild(scoreLabel)

        // Display high score
        let highScoreLabel = SKLabelNode(text: "High Score: \(highScore)")
        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontSize = 30
        highScoreLabel.fontColor = .black
        highScoreLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.5)
        addChild(highScoreLabel)

        // "Menu" button
        let menuButton = SKLabelNode(text: "Menu")
        menuButton.name = "menuButton"
        menuButton.fontName = "AvenirNext-Bold"
        menuButton.fontSize = 30
        menuButton.fontColor = .blue
        menuButton.position = CGPoint(x: size.width / 2 - 100, y: size.height * 0.3)
        addChild(menuButton)

        // "Play Again" button
        let playAgainButton = SKLabelNode(text: "Play Again")
        playAgainButton.name = "playAgainButton"
        playAgainButton.fontName = "AvenirNext-Bold"
        playAgainButton.fontSize = 30
        playAgainButton.fontColor = .green
        playAgainButton.position = CGPoint(x: size.width / 2 + 100, y: size.height * 0.3)
        addChild(playAgainButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNode = atPoint(location)

        if tappedNode.name == "menuButton" {
            print("Menu button tapped!")
            // Transition to the GameScene
            let mainMenuScene = GameScene(size: self.size)
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(mainMenuScene, transition: transition)
        } else if tappedNode.name == "playAgainButton" {
            print("Play Again button tapped!")
            // Transition to the PlayGameScene
            let playGameScene = PlayGameScene(size: self.size)
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(playGameScene, transition: transition)
        }
    }
}
