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
    case gameover
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
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        
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
            
            let listOfElements = [
                ScreenElements("🍏","manzana", 10),
                ScreenElements("🍉","sandia", 6),
                ScreenElements("🍌","platano", 5),
                ScreenElements("🍊","naranja", 4),
                ScreenElements("🍇","uva", 3),
                ScreenElements("🍍","piña", 2),
                ScreenElements("🍒","cereza", 1),
                ScreenElements("🍐","pera", 1),
                ScreenElements("💣","bomb", -15),
                ScreenElements("🧨","tnt", -25)
            ]
            
            for node in nodes(at: location){
                for element in listOfElements {
                    if node.name == element.name {
                        score += element.score
                        node.removeFromParent()
                        
                        if score <= 0 {
                            gameOver()
                            score = 0
                        }
                        
                        scoreLabel.text = "\(score)"
                    }
            }
        }
    }
    }
    
    
    func startGame(){
        promptLabel.isHidden = true
        fruitThrowTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {_ in self.createFruits()})
    }
    
    
    func createFruits() {
        let numberOfFruits = 1 + Int(arc4random_uniform(UInt32(4)))
        
        for _ in 0..<numberOfFruits {
            
            let fruit = Fruit()
            fruit.position.x = randomCGFfloat(0, size.width)
            fruit.position.y = -100
            addChild(fruit)
            
            if fruit.position.x < size.width/2 {
                fruit.physicsBody?.velocity.dx = randomCGFfloat(0, 200)
            }
            
            if fruit.position.x > size.width/2 {
                fruit.physicsBody?.velocity.dx = randomCGFfloat(0, -200)
            }
            
            fruit.physicsBody?.velocity.dy = randomCGFfloat(500, 800)
            fruit.physicsBody?.angularVelocity = randomCGFfloat(-5, 5)
        }
    }
    
    
    func missFruit() {
        
    }
    
    
    func bombExplode() {
        
    }
    
    
    func gameOver() {
        promptLabel.isHidden = false
        promptLabel.text = "Game Over"
        promptLabel.setScale(0)
        promptLabel.run(SKAction.scale(to: 1, duration: 0.3))
        
        gamePhase = .gameover
        
        fruitThrowTimer.invalidate()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: {_ in self.gamePhase = .ready})
    }
}

