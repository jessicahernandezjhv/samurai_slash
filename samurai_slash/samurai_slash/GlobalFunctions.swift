//
//  GlobalFunctions.swift
//  samurai_slash
//
//  Created by Jessica Hernandez on 11/05/2019.
//  Copyright © 2019 Jessica Hernandez. All rights reserved.
//

import Foundation
import UIKit

func randomCGFfloat(_ lowerLimit: CGFloat, _ upperLimit: CGFloat) -> CGFloat {
    return lowerLimit + CGFloat(arc4random()) / CGFloat(UInt32.max) * (upperLimit - lowerLimit)
}
