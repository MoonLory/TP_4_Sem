//
//  MyCell.swift
//  Task_2.2
//
//  Created by Admin on 18/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
class Act: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    var viewController = ViewController()
    var tableView = UITableView()
    var parties:NSSet = NSSet()
    
    @IBAction func buttonTapped(_ sender: Any) {
       viewController.parties = parties
              viewController.partiesTableView.reloadData()
              viewController.partiesView.isHidden = false
    }
}
