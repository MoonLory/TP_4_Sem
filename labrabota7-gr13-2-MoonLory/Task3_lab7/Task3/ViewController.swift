//
//  ViewController.swift
//  Task3_lab3
//
//  Created by Admin on 18/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var activitySegmentControl: UISegmentedControl!
    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBAction func calculateTapped(_ sender: Any) {
        resultsLabel.text = "Вы должны потреблять "
        resultsLabel.text = resultsLabel.text! +
            String(format: "%.0f",
                   BodyCalculator.calculateDailyCalories(weight: Double(weightTextField.text ?? ""),
                                                         height: Double(heightTextField.text ?? ""),
                                                         age: Int(ageTextField.text ?? ""),
                                                         isMan: sexSegmentControl.selectedSegmentIndex == 0 ||
                                                                sexSegmentControl.selectedSegmentIndex == UISegmentedControl.noSegment,
                                                         lifestyle: activitySegmentControl.selectedSegmentIndex))
        resultsLabel.text = resultsLabel.text! + " килокалорий для поддержания веса. Индекс массы тела "
        resultsLabel.text = resultsLabel.text! +
            String(format: "%.0f",
                   BodyCalculator.calculateBodyMassIndex(weight: Double(weightTextField.text ?? ""),
                                                         height: Double(heightTextField.text ?? "")))
        resultsLabel.text = resultsLabel.text! + "."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

