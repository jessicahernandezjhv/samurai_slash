//
//  Fruit.swift
//  samurai_slash
//
//  Created by Jessica Hernandez on 11/05/2019.
//  Copyright © 2019 Jessica Hernandez. All rights reserved.
//

import SpriteKit

class Fruit: SKNode {
    
    let fruitEmojis = ["🍏","🍉","🍌","🍊","🍓", "🍇", "🍍", "🍒", "🍐"]
    let bombEmoji = ["💣", "🧨"]
    
    override init(){
        super.init()
        
        var emoji = ""
        
        if randomCGFfloat(0, 1) < 0.9 {
            name = "fruit"
            let n = Int(arc4random_uniform(UInt32(fruitEmojis.count)))
            emoji = fruitEmojis[n]
            
        } else {
            name = "bomb"
            let n = Int(arc4random_uniform(UInt32(bombEmoji.count)))
            emoji = bombEmoji[n]
        }
        
        let label = SKLabelNode(text: emoji)
        label.fontSize = 120
        label.verticalAlignmentMode = .center
        addChild(label)
        
        physicsBody = SKPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


