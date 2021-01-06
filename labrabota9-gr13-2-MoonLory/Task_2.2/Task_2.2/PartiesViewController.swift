//
//  PartiesViewController.swift
//  Task_2.2
//
//  Created by Admin on 18/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class PartiesViewController: UIViewController,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = (parties.allObjects[counter] as! Party).rusDescriptions
        return cell
    }
    
    
   var partiesView = UIView()
    var tablePartiesView = UITableView()
    var parties = NSSet()
    var counter = 0
    var languageCode = 0
    
    init(view:UIView,tableView:UITableView,parties:NSSet, languageCode:Int) {
        partiesView = view
        tablePartiesView = tableView
        self.parties = parties
        self.languageCode = languageCode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
