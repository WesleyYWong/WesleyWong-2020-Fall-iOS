//
//  FirstViewController.swift
//  Assignment1
//
//  Created by user180084 on 9/10/20.
//  Copyright © 2020 WesleyWong. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    var highScore = 0
    
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
  
    
    @IBAction func pressmeTepped(_ sender: Any) {
        
        let concatentedString = "Hello \(firstName.text!) \(lastName.text!)"
        
        outputLabel.text = concatentedString
    }
    
   }

	
