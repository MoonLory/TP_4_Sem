//
//  ViewController.swift
//  task1-4
//
//  Created by Admin on 06/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gestureIndicator: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureIndicator.isUserInteractionEnabled = true
        gestureIndicator.textAlignment = NSTextAlignment.center
        gestureIndicator.numberOfLines = 2
        gestureIndicator.text = "Используйте жесты в этой области"
        gestureIndicator.backgroundColor = UIColor.yellow
    }

    // tap the touchpad
    @IBAction func tap(_ sender: Any) {
        gestureIndicator.text = "Жест: касание\n Цвет фона: зеленый"
        gestureIndicator.backgroundColor = UIColor.green
    }
    
    // press
    @IBAction func longPress(_ sender: Any) {
        gestureIndicator.text = "Жест: долгое нажатие\n Цвет фона: оранжевый"
        gestureIndicator.backgroundColor = UIColor.orange
    }
    
    // opt (better on sides)
    @IBAction func pinch(_ sender: Any) {
        gestureIndicator.text = "Жест: масштабирование\n Цвет фона: красный"
        gestureIndicator.backgroundColor = UIColor.red
    }
    
    // the same
    @IBAction func rotation(_ sender: Any) {
        gestureIndicator.text = "Жест: вращение\n Цвет фона: синий"
        gestureIndicator.backgroundColor = UIColor.blue
    }
    
    // swipe across
    @IBAction func swipe(_ sender: Any) {
        gestureIndicator.text = "Жест: смахивание\n Цвет фона: серый"
        gestureIndicator.backgroundColor = UIColor.lightGray
    }
    
    
}

