//
//  GameScene.swift
//  samurai_slash
//
//  Created by Jessica Hernandez on 11/05/2019.
//  Copyright © 2019 Jessica Hernandez. All rights reserved.
//

import SpriteKit

enum GamePhase {
    case ready
    case playing
}

class GameScene: SKScene {
    
    var gamePhase = GamePhase.ready
    var score = 0
    var best = 0
    
    var promptLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var bestLabel = SKLabelNode()
    
    var fruitThrowTimer = Timer()
    
    
    override func didMove(to view: SKView) {
        promptLabel = childNode(withName: "promptLabel") as! SKLabelNode
        
        scoreLabel = childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "\(score)"
        
        bestLabel = childNode(withName: "bestLabel") as! SKLabelNode
        bestLabel.text = "Best: \(best)"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gamePhase == .ready {
            gamePhase = .playing
            startGame()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
        }
    }
    
    
    func startGame(){
        promptLabel.isHidden = true
    }
    
    
    func createFruits() {

    }
    
    
    func missFruit() {
        
    }
    
    
    func bombExplode() {
        
    }
    
    
    func gameOver() {
        
    }
}