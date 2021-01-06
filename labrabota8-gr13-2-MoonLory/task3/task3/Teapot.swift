//
//  Teapot.swift
//  task3
//
//  Created by Admin on 06/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import GLKit

class Teapot {
    var Vertices : [Vertex] = []
    
    static var Indices : [GLbyte] = [0, 6, 1,
                                     1, 7, 2,
                                     2, 8, 3,
                                     4, 9, 3,
                                     4, 5, 10,
                                     5, 0, 11,
                                     0, 6, 11,
                                     1, 6, 7,
                                     2, 8, 7,
                                     3, 9, 8,
                                     4, 9, 10,
                                     5, 11, 10,
                                     6, 11, 12,
                                     6, 7, 12,
                                     7, 8, 12,
                                     8, 9, 12,
                                     9, 10, 12,
                                     10, 11, 12,
                                     
                                     0, 13, 1,
                                     1, 14, 2,
                                     2, 15, 3,
                                     4, 16, 3,
                                     4, 5, 17,
                                     5, 0, 18,
                                     0, 13, 18,
                                     1, 13, 14,
                                     2, 15, 14,
                                     3, 16, 15,
                                     4, 16, 17,
                                     5, 18, 17,
                                     13, 18, 19,
                                     13, 14, 19,
                                     14, 15, 19,
                                     15, 16, 19,
                                     16, 17, 19,
                                     17, 18, 19]
    
    init() {
        
        let c1 : Float = 3 * sqrt(3) / 2
        let c2 : Float = sqrt(3)
        
        let red : GLfloat = 0.05
        let green : GLfloat = 0.05
        let blue : GLfloat = 0.05
        
        let x_s: [Float] = [0, c1, c1, 0, -c1, -c1,
                            1, 2, 1, -1, -2, -1,
                            0,
                            1, 2, 1, -1, -2, -1,
                            0]
        let y_s : [Float] = [ 3, 1.5, -1.5, -3, -1.5, 1.5,
                              c2, 0, -c2, -c2, 0, c2,
                              0,
                              c2, 0, -c2, -c2, 0, c2,
                              0]
        let z_s: [Float] = [  0,  0,  0,  0,  0,  0,
                              2,  2,  2,  2,  2,  2,
                              3,
                             -2, -2, -2, -2, -2, -2,
                              -3]
        
        for i in stride(from: 0, to: 20, by: 1) {
            Vertices.append(Vertex(x: x_s[i],
                                   y: y_s[i],
                                   z: z_s[i],
                                   r: red * Float(i),
                                   g: green * Float(i),
                                   b: blue * Float(i),
                                   a: 1))
            print(x_s[i],
                  y_s[i],
                  z_s[i])
        }
    }
}
