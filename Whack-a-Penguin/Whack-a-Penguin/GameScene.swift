//
//  GameScene.swift
//  Project14
//
//  Created by TwoStraws on 18/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var gameScore: SKLabelNode!
    
    // MARK: - Challenge 1
    var gameOverLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    var slots = [WhackSlot]()
    var popupTime = 0.85
    var numRounds = 0
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            self.createEnemy()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            
            for node in tappedNodes {
                if node.name == "charFriend" {
                    // they shouldn't have whacked this penguin
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.isVisible { continue }
                    if whackSlot.isHit { continue }
                    
                    whackSlot.hit()
                    score -= 5
                    //MARK: - Challenge 1
                    run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion:false))
                    //MARK: - Challenge 3
                    if let smokeParticles = SKEmitterNode(fileNamed: "SmokeParticles") {
                          smokeParticles.position = whackSlot.position
                          addChild(smokeParticles)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700)) {
                            smokeParticles.removeFromParent()
                        }
                      }
                } else if node.name == "charEnemy" {
                    // they should have whacked this one
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.isVisible { continue }
                    if whackSlot.isHit { continue }
                    
                    whackSlot.charNode.xScale = 0.85
                    whackSlot.charNode.yScale = 0.85
                    
                    whackSlot.hit()
                    score += 1
                    //MARK: - Challenge 1
                    run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion:false))
                    //MARK: - Challenge 3
                    if let smokeParticles = SKEmitterNode(fileNamed: "SmokeParticles") {
                          smokeParticles.position = whackSlot.position
                          addChild(smokeParticles)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700)) {
                            smokeParticles.removeFromParent()
                        }
                      }
                  
                }
            }
        }
    }
    
    func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    func createEnemy() {
        numRounds += 1
        
        if numRounds >= 10 {
            for slot in slots {
                slot.hide()
            }
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
            // MARK: - Challenge 1
            gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
            gameOverLabel.text = "Final Score: \(score)"
            gameOverLabel.position = CGPoint(x: 512, y: 312)
            gameOverLabel.zPosition = 99
            gameOverLabel.fontSize = 48
            addChild(gameOverLabel)
            
            //MARK: - Challenge 2
            //TODO: - Update with your voice record
            run(SKAction.playSoundFileNamed("game-over.wav", waitForCompletion:false))
            
            return
        }
        
        popupTime *= 0.991
        
        slots.shuffle()
        slots[0].show(hideTime: popupTime)
        
        if Int.random(in: 0...12) > 4 { slots[1].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 8 {  slots[2].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 10 { slots[3].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 11 { slots[4].show(hideTime: popupTime)  }
        
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = Double.random(in: minDelay...maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            self.createEnemy()
        }
    }
}
