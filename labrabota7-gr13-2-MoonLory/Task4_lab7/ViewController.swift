//
//  ViewController.swift
//  Task4_lab7
//
//  Created by Admin on 19/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var num1: UITextField!
    @IBOutlet weak var num2: UITextField!
    @IBOutlet weak var textans: UILabel!
    @IBOutlet weak var perekl: UISegmentedControl!
    @IBAction func ans(_ sender: Any) {
        
        
        let n1=Double(num1.text ?? "0") ?? 0.0;
        let n2=Double(num2.text ?? "0") ?? 0.0;
        
        if (perekl.selectedSegmentIndex==0){
            textans.text="Ответ: "+String(n1+n2);
            
        }
        else{
            textans.text="Ответ: "+String(n1-n2);
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

