//
//  Hexagon.swift
//  task2-2
//
//  Created by Admin on 06/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

@IBDesignable class HexagonView: UIView {

    override func draw(_ rect: CGRect) {
        let hex = Hexagon(bounds.width - 10)
        
        let context = UIGraphicsGetCurrentContext()!
        
        let shadow: UIColor = UIColor.black.withAlphaComponent(0.80)
        let shadowOffset = CGSize(width: 5.0, height: 5.0)
        let shadowBlurRadius: CGFloat = 10
        
        context.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: shadow.cgColor)
        
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let path = UIBezierPath()
        path.move(to: hex.vertices[5])
        for hv in hex.vertices {
            path.addLine(to: hv)
        }
        
        path.addClip()
        
        let colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0, 1])!
        context.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: bounds.height), options: [])
        
        context.endTransparencyLayer()
    }

}
