//
//  CurvilinearTriangle.swift
//  task2-2
//
//  Created by Admin on 06/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

struct arcFeatures {
    var center: CGPoint
    var startAngle: CGFloat
    var endAngle: CGFloat
}

class CurvilinearTriangle {
    var r: CGFloat
    var start: arcFeatures
    var arcs: [arcFeatures] = []
    
    init(_ a: CGFloat) {
        r = (a / 2) * sqrt(3)
        
        start = arcFeatures(center: CGPoint(x: a / 2, y: 0),
                                startAngle: .pi / 3,
                                endAngle: 2 * .pi / 3)
        
        arcs.append(arcFeatures(center: CGPoint(x: ((2 - sqrt(3)) / 4) * a, y: 3 / 4 * a),
                                startAngle: -1 * .pi / 3,
                                endAngle: 0))
        arcs.append(arcFeatures(center: CGPoint(x: ((2 + sqrt(3)) / 4) * a, y: 3 / 4 * a),
                                startAngle: -1 * .pi,
                                endAngle: -2 * .pi / 3))
    }
}
