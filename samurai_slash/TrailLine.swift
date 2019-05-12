//
//  TrailLine.swift
//  samurai_slash
//
//  Created by Jessica Hernandez on 12/05/2019.
//  Copyright © 2019 Jessica Hernandez. All rights reserved.
//

import SpriteKit

class TrailLain: SKShapeNode {
    
    var shrinkTimer = Timer()
    
    init(position: CGPoint, lastPosition: CGPoint, width: CGFloat, color: UIColor) {
        super.init()
        
        let path = CGMutablePath()
        path.move(to: position)
        path.addLine(to: lastPosition)
        
        self.path = path
        lineWidth = width
        strokeColor = color
        
        shrinkTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: {_
            in
            
            self.lineWidth -= 1
            if self.lineWidth == 0 {
                self.shrinkTimer.invalidate()
                self.removeFromParent()
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
