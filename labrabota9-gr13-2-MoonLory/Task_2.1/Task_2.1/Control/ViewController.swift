//
//  ViewController.swift
//  Task_2.1
//
//  Created by Admin on 18/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UICollectionViewDataSource{
    
    //MARK: - properties
    
    @IBOutlet weak var informCollectionView: UICollectionView!
    @IBOutlet weak var informView: UIView!
    @IBOutlet weak var languageSelectedControl: UISegmentedControl!
    @IBOutlet weak var rulesSwitch: UISwitch!
    @IBOutlet weak var registerSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginV: UIView!
    @IBOutlet weak var logLoginTextField: UITextField!
    
    @IBOutlet weak var logPasswordTextField: UITextField!
    @IBOutlet weak var regV: UIView!
    @IBOutlet weak var regLoginTextField: UITextField!
    @IBOutlet weak var regEmailTextField: UITextField!
    @IBOutlet weak var regPasswordTextField: UITextField!
    @IBOutlet weak var regRepeatPasswordField: UITextField!
    
    var descriptions: Array<String> = []
    var names: Array<String> = []
    var imagePaths: Array<String> = []
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - UICollectionView functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return descriptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let act = informCollectionView.dequeueReusableCell(withReuseIdentifier: "act", for: indexPath) as! Act
        act.myDesription = descriptions[counter]
        if(act.isOpened){
            act.isOpened = false
            act.labelName.text = ""
        }
        
        act.button.setTitle(names[counter], for: .normal)
        act.imageView.image = UIImage(named: imagePaths[counter])
        counter+=1
        return act
    }
    
    //MARK: - login interface

    @IBAction func registerButtonTapped(_ sender: Any) {
        if(regLoginTextField.text != "" && regPasswordTextField.text != "" && regEmailTextField.text != "" && regRepeatPasswordField.text != "")
        {
            if(regRepeatPasswordField.text == regPasswordTextField.text)
            {
                if(rulesSwitch.isOn)
                {
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(regLoginTextField.text, forKey: "login")
                    userDefaults.set(regPasswordTextField.text,forKey: "password")
                    userDefaults.set(regEmailTextField.text,forKey: "email")
                    loadCurrentLocalization()
                    informCollectionView.reloadData()
                    loginV.isHidden = true
                    informView.isHidden = false
                }
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if(logLoginTextField.text != "" && logPasswordTextField.text != "")
        {
            let userDefaults = UserDefaults.init()
            if(userDefaults.string(forKey: "login") ?? "" == logLoginTextField.text && userDefaults.string(forKey: "password") ?? "" == logPasswordTextField.text)
            {
                loadCurrentLocalization()
                informCollectionView.reloadData()

                loginV.isHidden = true
                informView.isHidden = false
            }
        }
    }
    
    @IBAction func registerSegmentedControlSelected(_ sender: Any) {
        let code = registerSegmentedControl.selectedSegmentIndex
        regV.isHidden = (code == 0)
    }
    
    
    @IBAction func languageSegmentedControlSelected(_ sender: Any) {
        loadCurrentLocalization()
        informCollectionView.reloadData()
    }
    
    func loadCurrentLocalization(){
        counter = 0;
        let code = languageSelectedControl.selectedSegmentIndex
        switch(code){
        case 0:
            names = loadData(name: "engData")
            descriptions = loadData(name: "engDescriptions")
        case 1:
            names = loadData(name: "rusData")
            descriptions = loadData(name: "rusDescriptions")
        case 2:
            names = loadData(name: "byData")
            descriptions = loadData(name: "byDescriptions")
        default: break
        }
        imagePaths = loadData(name: "imagePaths")
    }
    
    
    func loadData(name:String)->Array<String>{
        let plistPath: String? = Bundle.main.path(forResource: name, ofType: "plist")
        var values:Array<String> = []
        if(plistPath != nil ){
            let myArray = NSArray(contentsOfFile: plistPath!)
            if let arr = myArray{
                values = arr as! Array<String>
            }
            else
            {
                print("load fail")
            }
        }
        return values
    }
      
}
