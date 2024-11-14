import SpriteKit

class PlayGameScene: SKScene {
    
    let emails = [
        ("Subject: Job Offer\nDear User, We noticed your profile and have a special work-from-home job for you!", true),
        ("Subject: Recruitment Alert\nBecome a data entry specialist and earn $500 daily. Apply now!", true),
        ("Subject: Easy Job Opportunity\nJoin our team and make thousands per month. No experience needed.", true),
        ("Subject: Work from Home\nCongratulations! You're pre-approved for a remote job. Click to proceed.", true),
        ("Subject: Hiring Now\nEarn up to $10,000 monthly by working 2 hours daily. Sign up today!", true),
        ("Subject: Career Opportunity\nWe reviewed your resume and would like to discuss a position with our company.", false),
        ("Subject: Software Engineer Role\nWe are impressed with your skills and want to invite you to apply.", false),
        ("Subject: Full-Time Role\nJoin our team as a project manager. Salary: $80K-$100K/year.", false),
        ("Subject: Marketing Specialist Wanted\nImmediate opening for an experienced professional.", false),
        ("Subject: Analyst Position\nWe’re hiring analysts to join our team. Competitive benefits included.", false)
    ]
    
    var currentEmail: SKLabelNode?
    var currentEmailIsSpam: Bool = false
    var health = 100
    var score = 0
    var healthLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var swipeInProgress = false
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        spawnNewEmail()
        setupHealthBar()
        setupScoreLabel()
    }
    
    func spawnNewEmail() {
        currentEmail?.removeFromParent()
        let randomIndex = Int.random(in: 0..<emails.count)
        let email = emails[randomIndex]
        currentEmailIsSpam = email.1
        
        let emailLabel = SKLabelNode(text: email.0)
        emailLabel.fontName = "AvenirNext-Bold"
        emailLabel.fontSize = 18
        emailLabel.fontColor = .black
        emailLabel.numberOfLines = 0
        emailLabel.horizontalAlignmentMode = .center
        emailLabel.preferredMaxLayoutWidth = size.width * 0.8
        emailLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(emailLabel)
        
        currentEmail = emailLabel
    }
    
    func setupHealthBar() {
        healthLabel = SKLabelNode(text: "Health: \(health)")
        healthLabel.fontName = "AvenirNext-Bold"
        healthLabel.fontSize = 24
        healthLabel.fontColor = .red
        
        if let view = view {
            let safeAreaTop = view.safeAreaInsets.top
            healthLabel.position = CGPoint(x: size.width / 2, y: size.height - safeAreaTop - 20)
        } else {
            healthLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        }
        
        addChild(healthLabel)
    }
    
    func setupScoreLabel() {
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = .blue
        
        if let view = view {
            let safeAreaTop = view.safeAreaInsets.top
            scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - safeAreaTop - 50)
        } else {
            scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 80)
        }
        
        addChild(scoreLabel)
    }
    
    func updateHealth() {
        healthLabel.text = "Health: \(health)"
    }
    
    func updateScore() {
        scoreLabel.text = "Score: \(score)"
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !swipeInProgress else { return }
        let start = touch.previousLocation(in: self)
        let end = touch.location(in: self)
        
        let dx = end.x - start.x
        let dy = end.y - start.y
        
        if abs(dx) > abs(dy) {
            swipeInProgress = true
            if dx > 0 {
                handleSwipe(isSpam: false) // Swipe right
            } else {
                handleSwipe(isSpam: true)  // Swipe left
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
            spawnNewEmail()
        } else {
            gameOver()
        }
    }
    
    func gameOver() {
        print("Game Over! Health reached 0.")
    }
}
