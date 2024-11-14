//
//  GameScene.swift
//  cyber
//
//  Created by Arrion Knight on 11/14/24.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        // Title
        let titleLabel = SKLabelNode(text: "Welcome to Spam Fighter")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontSize = 20
        titleLabel.fontColor = .black
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        addChild(titleLabel)
        
        // Play Button
        let playButton = SKLabelNode(text: "Play")
        playButton.name = "playButton"  // Identify the button
        playButton.fontName = "AvenirNext-Bold"
        playButton.fontSize = 30
        playButton.fontColor = .blue
        playButton.position = CGPoint(x: size.width / 2, y: size.height * 0.5)
        addChild(playButton)
        
        // Instructions Button
        let instructionsButton = SKLabelNode(text: "Instructions")
        instructionsButton.name = "instructionsButton"  // Identify the button
        instructionsButton.fontName = "AvenirNext-Bold"
        instructionsButton.fontSize = 30
        instructionsButton.fontColor = .green
        instructionsButton.position = CGPoint(x: size.width / 2, y: size.height * 0.4)
        addChild(instructionsButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNode = atPoint(location)
        
        if tappedNode.name == "playButton" {
            // Handle play button tap - Transition to game scene
            print("Play button tapped!")
            // Add transition to game scene here
        } else if tappedNode.name == "instructionsButton" {
            // Handle instructions button tap
            print("Instructions button tapped!")
            // Add code to show instructions
        }
    }
}
