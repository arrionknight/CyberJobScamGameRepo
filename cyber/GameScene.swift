import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupTitle()
        setupButtons()
    }
    
    private func setupBackground() {
        // Add your custom PNG as the background
        let background = SKSpriteNode(imageNamed: "bg-main2") // Use your PNG name here
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )
        background.zPosition = -1 // Ensure it stays behind everything else
        background.size = size // Stretch or fit the image to the scene size
        addChild(background)
    }

    private func setupTitle() {
        // Title
        let titleLabel = SKLabelNode(text: "Spam Fighter")
        titleLabel.fontName = "Chalkduster"
        titleLabel.fontSize = 48
        titleLabel.fontColor = .yellow
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.75)
        
        // Add a glowing animation to the title
        let fadeOut = SKAction.fadeAlpha(to: 0.5, duration: 0.5)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        let pulse = SKAction.sequence([fadeOut, fadeIn])
        titleLabel.run(SKAction.repeatForever(pulse))
        
        addChild(titleLabel)
    }
    
    private func setupButtons() {
        let yOffset: CGFloat = 100 // Adjust this value to move buttons down
        
        // Play Button
        let playButton = createButton(text: "Play", color: .blue, yPosition: size.height * 0.5 - yOffset)
        playButton.name = "playButton"
        addChild(playButton)
        
        // Instructions Button
        let instructionsButton = createButton(text: "Instructions", color: .green, yPosition: size.height * 0.4 - yOffset)
        instructionsButton.name = "instructionsButton"
        addChild(instructionsButton)
    }
    
    private func createButton(text: String, color: UIColor, yPosition: CGFloat) -> SKShapeNode {
        // Create a larger rounded rectangle button
        let button = SKShapeNode(rectOf: CGSize(width: 250, height: 60), cornerRadius: 15)  // Increased width and height
        button.fillColor = color
        button.position = CGPoint(x: size.width / 2, y: yPosition)
        
        // Add label to the button
        let label = SKLabelNode(text: text)
        label.fontName = "AvenirNext-Bold"
        label.fontSize = 24 // Slightly larger font size for better readability
        label.fontColor = .white
        label.verticalAlignmentMode = .center
        label.zPosition = 1
        button.addChild(label)
        
        return button
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNode = atPoint(location)
        
        // Check if the play button was tapped
        if tappedNode.name == "playButton" {
            print("Play button tapped!")
            // Transition to the PlayGameScene
            let playGameScene = PlayGameScene(size: self.size)
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(playGameScene, transition: transition)
        }
        // Check if the instructions button was tapped
        else if tappedNode.name == "instructionsButton" {
            print("Instructions button tapped!")
            // Transition to the InstructionsScene
            let instructionsScene = InstructionsScene(size: self.size)
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(instructionsScene, transition: transition)
        }
    }
}
