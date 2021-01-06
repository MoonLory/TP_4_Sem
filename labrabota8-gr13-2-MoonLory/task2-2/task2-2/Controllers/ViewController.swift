//
//  ViewController.swift
//  task2-2
//
//  Created by Admin on 06/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentShape: UISegmentedControl!
    
    @IBOutlet weak var curvTriangleView: CurvilinearTriangleView!
    @IBOutlet weak var hexagonView: HexagonView!
    
    @IBOutlet weak var moveSwitch: UISwitch!
    @IBOutlet weak var rotateSwitch: UISwitch!
    @IBOutlet weak var changeSizeSwitch: UISwitch!
    @IBOutlet weak var transparencySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curvTriangleView.isHidden = false
        curvTriangleView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        hexagonView.isHidden = true
        hexagonView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }

    @IBAction func changeGeometricShape(_ sender: Any) {
        switch (currentShape.selectedSegmentIndex) {
        case 0:
            curvTriangleView.isHidden = false
            hexagonView.isHidden = true
            break
        case 1:
            curvTriangleView.isHidden = true
            hexagonView.isHidden = false
            break
        default:
            break
        }
    }
    
    @IBAction func rotate(_ sender: Any) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg1")!)
    }
    
    @IBAction func pinch(_ sender: Any) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg2")!)
    }
    
    @IBAction func tap(_ sender: Any) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg3")!)
    }
    
    @IBAction func longPress(_ sender: Any) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg4")!)
    }
    
    @IBAction func swipe(_ sender: Any) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg5")!)
    }
    
    @IBAction func animateView(_ sender: Any) {
        let currentView: UIView = hexagonView.isHidden ? curvTriangleView : hexagonView
        
        if (moveSwitch.isOn) {
            currentView.center.x -= 350
        }
        if (rotateSwitch.isOn) {
            currentView.transform = CGAffineTransform(rotationAngle: .pi)
        }
        if (changeSizeSwitch.isOn) {
            currentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }
        if (transparencySwitch.isOn) {
            currentView.alpha = 0
        }
        
        UIView.animate(withDuration: 2, animations: {
            if (self.moveSwitch.isOn) {
                currentView.center.x += 350
            }
            if (self.rotateSwitch.isOn) {
                currentView.transform = CGAffineTransform(rotationAngle: .pi)
            }
            if (self.transparencySwitch.isOn) {
                currentView.alpha = 1
            }
            currentView.transform = CGAffineTransform.identity
        })
    }
    
}

