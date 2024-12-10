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
        let titleLabel = SKLabelNode(text: "Instructions")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontSize = 40
        titleLabel.fontColor = .black
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.8)
        addChild(titleLabel)
        
        // Instruction text
        let instructionText = SKLabelNode(text: "Tap Play to start the game.\nAvoid spam and win!")
        instructionText.fontName = "AvenirNext"
        instructionText.fontSize = 24
        instructionText.fontColor = .darkGray
        instructionText.position = CGPoint(x: size.width / 2, y: size.height * 0.5)
        instructionText.horizontalAlignmentMode = .center
        instructionText.numberOfLines = 2
        addChild(instructionText)
    }

    private func setupBackButton() {
        // Back Button
        let backButton = SKLabelNode(text: "Back")
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
