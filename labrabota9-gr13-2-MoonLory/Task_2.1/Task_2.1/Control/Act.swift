//
//  Act.swift
//  Task_2.1
//
//  Created by Admin on 18/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class Act: UICollectionViewCell {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    var myDesription = ""
    var isOpened = false
    
    @IBAction func buttonTapped(_ sender: Any) {
        if(!isOpened){
            labelName.text = myDesription
        }
        else{
            labelName.text = ""
        }
        isOpened = !isOpened
    }
}
