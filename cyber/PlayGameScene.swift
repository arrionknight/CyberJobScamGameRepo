import SpriteKit
import WebKit
import UIKit


class PlayGameScene: SKScene {
    
    var emails: [(String, Bool)] = []
    var currentEmail: SKLabelNode?
    var currentEmailIsSpam: Bool = false
    var health = 100
    var score = 0
    var highScore = UserDefaults.standard.integer(forKey: "HighScore")
    var healthLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var swipeInProgress = false
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        loadEmailsFromJSON()
        setupLabels()
        spawnNewEmail()
        addBackgroundImage()
    }

    func addBackgroundImage() {
        // Create an SKSpriteNode for the background image
        let background = SKSpriteNode(imageNamed: "email-bg1")  // Use the name of your image
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)  // Center the background
        background.zPosition = -1  // Place the background behind other elements
        addChild(background)
    }
    
    func loadEmailsFromJSON() {
        guard let filePath = Bundle.main.path(forResource: "email", ofType: "json") else {
            print("email.json not found!")
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            
            // Update to handle the new JSON structure with multiple fields
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                for emailData in jsonArray {
                    // Extract the necessary fields from the JSON
                    if let title = emailData["title"] as? String,
                       let location = emailData["location"] as? String,
                       let description = emailData["description"] as? String,
                       let isSpam = emailData["isSpam"] as? Bool {
                        // Combine the extracted fields into a single string or use them separately
                        let emailContent = "Title: \(title)\nLocation: \(location)\nDescription: \(description)"
                        emails.append((emailContent, isSpam))
                    }
                }
            }
        } catch {
            print("Error loading emails from JSON: \(error)")
        }
    }


    
    func spawnNewEmail() {
        currentEmail?.removeFromParent()
            guard !emails.isEmpty else {
                gameOver(isWin: true) // Transition to a win screen when no emails are left
                return
            }
            
            let randomIndex = Int.random(in: 0..<emails.count)
            let email = emails.remove(at: randomIndex) // Prevent duplicate emails in the same session
            currentEmailIsSpam = email.1
            
            let emailLabel = SKLabelNode(text: email.0)
            emailLabel.fontName = "AvenirNext-Bold"
            emailLabel.fontSize = 18
            emailLabel.fontColor = .black
            emailLabel.numberOfLines = 0
            emailLabel.horizontalAlignmentMode = .center

            // Set preferred max layout width to a percentage of the screen width
            let maxWidth = size.width * 0.8
            emailLabel.preferredMaxLayoutWidth = maxWidth
            
            // Ensure the text fits within the bounds
            let labelHeight = emailLabel.calculateAccumulatedFrame().height
            let screenHeight = size.height
            let labelYPosition: CGFloat = screenHeight / 2 - labelHeight / 2
            
            emailLabel.position = CGPoint(x: size.width / 2, y: labelYPosition)
            
            addChild(emailLabel)
            
            currentEmail = emailLabel
        }
    
    func setupLabels() {
        healthLabel = createLabel(text: "Health: \(health)", fontColor: .red, yOffset: -20)
        scoreLabel = createLabel(text: "Score: \(score)", fontColor: .blue, yOffset: -50)
    }
    
    private func createLabel(text: String, fontColor: UIColor, yOffset: CGFloat) -> SKLabelNode {
        let label = SKLabelNode(text: text)
        label.fontName = "AvenirNext-Bold"
        label.fontSize = 24
        label.fontColor = fontColor

        if let view = view {
            let safeAreaTop = view.safeAreaInsets.top
            label.position = CGPoint(x: size.width / 2, y: size.height - safeAreaTop + yOffset)
        } else {
            label.position = CGPoint(x: size.width / 2, y: size.height + yOffset)
        }
        addChild(label)
        return label
    }
    
    func updateHealth() {
        healthLabel.text = "Health: \(health)"
    }
    
    func updateScore() {
        scoreLabel.text = "Score: \(score)"
    }
    
    func gameOver(isWin: Bool = false) {
        // Store the high score if the current score is higher
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "HighScore")
        }
        
        removeAllChildren() // Remove all current game objects
        
        let gameOverText = isWin ? "You Win!" : "Game Over"
        let gameOverLabel = SKLabelNode(text: gameOverText)
        gameOverLabel.fontName = "AvenirNext-Bold"
        gameOverLabel.fontSize = 48
        gameOverLabel.fontColor = isWin ? .green : .red
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = .black
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.5)
        addChild(scoreLabel)
        
        let highScoreLabel = SKLabelNode(text: "High Score: \(highScore)")
        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontSize = 24
        highScoreLabel.fontColor = .black
        highScoreLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.4)
        addChild(highScoreLabel)
        
        let menuButton = SKLabelNode(text: "Menu")
        menuButton.fontName = "AvenirNext-Bold"
        menuButton.fontSize = 24
        menuButton.fontColor = .blue
        menuButton.position = CGPoint(x: size.width / 2 - 50, y: size.height * 0.3)
        menuButton.name = "menuButton"
        addChild(menuButton)
        
        let replayButton = SKLabelNode(text: "Play Again")
        replayButton.fontName = "AvenirNext-Bold"
        replayButton.fontSize = 24
        replayButton.fontColor = .blue
        replayButton.position = CGPoint(x: size.width / 2 + 50, y: size.height * 0.3)
        replayButton.name = "replayButton"
        addChild(replayButton)
    }
    
    // Swipe detection code
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !swipeInProgress else { return }
        
        let start = touch.previousLocation(in: self)
        let end = touch.location(in: self)
        
        let dx = end.x - start.x
        let dy = end.y - start.y
        
        // Threshold for detecting a swipe (adjust as needed)
        let swipeThreshold: CGFloat = 30.0
        
        if abs(dx) > abs(dy) && abs(dx) > swipeThreshold {
            swipeInProgress = true // Prevent multiple detections
            if dx > 0 {
                handleSwipe(isSpam: false) // Swipe right (not spam)
            } else {
                handleSwipe(isSpam: true)  // Swipe left (spam)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        swipeInProgress = false
    }
    
    func handleSwipe(isSpam: Bool) {
        if isSpam == currentEmailIsSpam {
            score += 10
            updateScore()
        } else {
            health -= 10
            if health < 0 { health = 0 }
            updateHealth()
        }
        
        if health > 0 {
            spawnNewEmail()  // Continue the game if health is still greater than 0
        } else {
            gameOver()  // Call game over if health reaches 0
        }
    }
    

}
