//
//  Hexagon.swift
//  task2-2
//
//  Created by Admin on 06/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class Hexagon {
    var vertices: [CGPoint] = []
    
    init(_ a: CGFloat) {
        let coeff1: CGFloat = (2 - sqrt(3)) / 4
        let coeff2: CGFloat = (2 + sqrt(3)) / 4
        
        vertices.append(CGPoint(x: a / 4,     y: coeff1 * a))
        vertices.append(CGPoint(x: 3 * a / 4, y: coeff1 * a))
        vertices.append(CGPoint(x: a,         y: a / 2))
        vertices.append(CGPoint(x: 3 * a / 4, y: coeff2 * a))
        vertices.append(CGPoint(x: a / 4,     y: coeff2 * a))
        vertices.append(CGPoint(x: 0,         y: a / 2))
    }
}
