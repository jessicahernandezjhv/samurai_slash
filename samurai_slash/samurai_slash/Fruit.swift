//
//  Fruit.swift
//  samurai_slash
//
//  Created by Jessica Hernandez on 11/05/2019.
//  Copyright © 2019 Jessica Hernandez. All rights reserved.
//

import SpriteKit

struct ScreenElements {
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
    
    let listOfFruits = [
        ScreenElements("🍏","manzana", 10),
        ScreenElements("🍉","sandia", 6),
        ScreenElements("🍌","platano", 5),
        ScreenElements("🍊","naranja", 4),
        ScreenElements("🍇","uva", 3),
        ScreenElements("🍍","piña", 2),
        ScreenElements("🍒","cereza", 1),
        ScreenElements("🍐","pera", 1)]
    
    let listOfBombs = [
        ScreenElements("💣","bomb", -15),
        ScreenElements("🧨","tnt", -25)]
    
    
    override init(){
        super.init()
        var emoji = ""
        
        if randomCGFfloat(0, 1) < 0.6 {
            let n = Int(arc4random_uniform(UInt32(listOfFruits.count)))
            name = listOfFruits[n].name
            emoji = listOfFruits[n].emoji
            
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


