import SpriteKit

class InstructionsScene: SKScene {

    override func didMove(to view: SKView) {
        setupBackground()
        setupInstructions()
        setupBackButton()
    }

    private func setupBackground() {
        // Set a background color or image for the instructions scene
        backgroundColor = .white
    }

    private func setupInstructions() {
        // Title for the instructions
        let titleLabel = SKLabelNode(text: "Game Instructions")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontSize = 40
        titleLabel.fontColor = .black
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.85)
        addChild(titleLabel)
        
        // Detailed instruction text
        let instructionText = SKLabelNode(text: """
            1. Tap "Play" to start the game.

            """)
        instructionText.fontName = "AvenirNext"
        instructionText.fontSize = 22
        instructionText.fontColor = .darkGray
        instructionText.position = CGPoint(x: size.width / 2, y: size.height * 0.5)
        instructionText.horizontalAlignmentMode = .center
        instructionText.verticalAlignmentMode = .center
        instructionText.numberOfLines = 7
        addChild(instructionText)
    }

    private func setupBackButton() {
        // Back Button
        let backButton = SKLabelNode(text: "Back to Menu")
        backButton.name = "backButton"
        backButton.fontName = "AvenirNext-Bold"
        backButton.fontSize = 30
        backButton.fontColor = .blue
        backButton.position = CGPoint(x: size.width / 2, y: size.height * 0.2)
        addChild(backButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNode = atPoint(location)

        if tappedNode.name == "backButton" {
            print("Back button tapped!")
            // Transition back to the main menu scene
            let gameScene = GameScene(size: self.size)
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
}
