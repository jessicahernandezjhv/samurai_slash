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
    
    // Set game status before play
    var gamePhase = GamePhase.ready
    var score = 0
    var best = 0
    var missesMax = 3
    var misses = 0
    var generateFruitInverval = 2.5
    var velocityYLowerRandom : CGFloat = 500
    var velocityYUpperRandom : CGFloat = 800
    var angularVelocityLower : CGFloat = -5
    var angularVelocityUpper : CGFloat = 5
    var numberOfRandomFruits : CGFloat =  3.0

    
    // Set screen elements
    var promptLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var bestLabel = SKLabelNode()
    var explodeOverlay = SKShapeNode()
    var livesLabel = SKLabelNode()
    
    // Set timer
    var fruitThrowTimer = Timer()
    var matchTimer = Timer()
    
    
    override func didMove(to view: SKView) {
        promptLabel = childNode(withName: "promptLabel") as! SKLabelNode
        
        scoreLabel = childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "\(score)"
        
        bestLabel = childNode(withName: "bestLabel") as! SKLabelNode
        bestLabel.text = "Best: \(best)"
        
        livesLabel = childNode(withName: "livesLabel") as! SKLabelNode
        livesLabel.text = "Lives: \(missesMax-misses)"
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -4)
        
        explodeOverlay = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        explodeOverlay.fillColor = .white
        addChild(explodeOverlay)
        explodeOverlay.alpha = 0
        
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
            let previous = touch.previousLocation(in:self)
            
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

                        if score > best {
                            best = score
                            bestLabel.text = "Best: \(best)"
                        }
                        
                        if score <= 0 {
                            score = 0
                            gameOver()
                        }
                        
                        if node.name == "bomb" || node.name == "tnt" {
                            particleEffect(position: node.position)
                            bombExplode()
                        }
                        
                        scoreLabel.text = "\(score)"
                    }
                }
            }
        
            let line = TrailLain(position: location, lastPosition: previous, width: 8, color: .blue)
            addChild(line)

        }
    }
    
    
    func startGame(){
        score = 0
        best = 0
        misses = 0
        generateFruitInverval = 2.5
        velocityYLowerRandom = 500
        velocityYUpperRandom = 800
        angularVelocityLower = -5
        angularVelocityUpper = 5
        numberOfRandomFruits = 3.0
        generateFruitInverval = 2.5
        
        promptLabel.isHidden = true
        fruitThrowTimer = Timer.scheduledTimer(withTimeInterval: generateFruitInverval, repeats: true, block: {_ in self.createFruits()})
        matchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {_ in self.checkTimer()})
    }
    
    func checkTimer() {
        if velocityYUpperRandom < 1100 {
            generateFruitInverval -= 0.07
            velocityYLowerRandom += 1
            velocityYUpperRandom += 1
            angularVelocityLower += 1
            angularVelocityUpper += 1
            numberOfRandomFruits += 0.04
        } else {
            generateFruitInverval -= 0.01
            angularVelocityLower += 1
            angularVelocityUpper += 1
        }
    }
    
    
    override func didSimulatePhysics() {
        for case let fruit as Fruit in children {
            if fruit.name != "bomb" && fruit.name != "tnt" {
                if fruit.position.y < -100 {
                    missFruit()
                    fruit.removeFromParent()
                }
            }
        }
    }
    
    
    func createFruits() {
        var numberOfFruits = Int((randomCGFfloat(1, numberOfRandomFruits)).rounded())
        print(numberOfRandomFruits)
        print(numberOfFruits)
        print("-----")
        for _ in 0..<numberOfFruits {
            
            let fruit = Fruit()
            fruit.position.x = randomCGFfloat(0, size.width)
            fruit.position.y = -60
            addChild(fruit)
            
            if fruit.position.x < size.width/2 {
                fruit.physicsBody?.velocity.dx = randomCGFfloat(0, 200)
            }
            
            if fruit.position.x > size.width/2 {
                fruit.physicsBody?.velocity.dx = randomCGFfloat(0, -200)
            }
            
            var velocityY = randomCGFfloat(velocityYLowerRandom, velocityYUpperRandom)
            fruit.physicsBody?.velocity.dy = velocityY
            fruit.physicsBody?.angularVelocity = randomCGFfloat(-5, 5)
            }
    }
    
    
    func missFruit() {
        misses += 1
        livesLabel.text = "Lives: \(missesMax-misses)"
        
        if misses >= missesMax {
            gameOver()
            livesLabel.text = "Lives: 0"
        }
    }
    
    
    func bombExplode() {
        for case let fruit as Fruit in children {
            fruit.removeFromParent()
            particleEffect(position: fruit.position)
        }
        
        explodeOverlay.run(SKAction.sequence([
            SKAction.fadeAlpha(to: 1, duration: 0),
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeAlpha(to: 0, duration: 0),
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeAlpha(to: 1, duration: 0),
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeAlpha(to: 0, duration: 0)
            ]))
    }
    
    
    func gameOver() {
        scoreLabel.text = "\(score)"
        promptLabel.isHidden = false
        promptLabel.text = "Game Over"
        promptLabel.setScale(0)
        promptLabel.run(SKAction.scale(to: 1, duration: 0.3))
        
        gamePhase = .gameover
        
        fruitThrowTimer.invalidate()
        matchTimer.invalidate()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: {_ in self.gamePhase = .ready})
    }
    
    func particleEffect(position: CGPoint) {
        let emitter = SKEmitterNode(fileNamed: "Explode.sks")
        emitter?.position = position
        addChild(emitter!)
    }
}
