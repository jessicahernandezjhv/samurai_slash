//
//  Fruit.swift
//  samurai_slash
//
//  Created by Jessica Hernandez on 11/05/2019.
//  Copyright © 2019 Jessica Hernandez. All rights reserved.
//

import SpriteKit

class ScreenElements {
    var emoji =  String()
    var name =  String()
    var score =  Int()
    
    init(_ emoji: String, _ name: String, _ score: Int) {
        self.emoji = emoji
        self.name = name
        self.score = score
    }
    
}

class Fruit: SKNode {
    
    let listOfElements = [
        ScreenElements("🍏","manzana", 6),
        ScreenElements("🍉","sandia", 5),
        ScreenElements("🍌","platano", 5),
        ScreenElements("🍊","naranja", 4),
        ScreenElements("🍓","fresa", 4),
        ]
    
    let listOfBombs = [
        ScreenElements("💣","bomb", -10),
        ScreenElements("🧨","tnt", -20)
    ]
    
    //let fruitEmojis = ["🍏","🍉","🍌","🍊","🍓", "🍇", "🍍", "🍒", "🍐"]
    //let nameFruit = ["manzana","sandia","platano","naranja","fresa", "uva", "piña", "cereza", "pera"]
    //let bombEmoji = ["💣", "🧨"]
    //let bombName = ["bomb","tnt"]
    
    override init(){
        super.init()
        
        var emoji = ""
        
        if randomCGFfloat(0, 1) < 0.9 {
            let n = Int(arc4random_uniform(UInt32(listOfElements.count)))
            name = listOfElements[n].name
            emoji = listOfElements[n].emoji
            
        } else {
            
            let n = Int(arc4random_uniform(UInt32(listOfBombs.count)))
            name = listOfBombs[n].name
            emoji = listOfBombs[n].emoji
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


