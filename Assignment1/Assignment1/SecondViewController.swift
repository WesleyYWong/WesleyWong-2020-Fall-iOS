//
//  SecondViewController.swift
//  Assignment1
//
//  Created by user180084 on 9/10/20.
//  Copyright © 2020 WesleyWong. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

   
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var opacityLabel: UILabel!
    @IBOutlet weak var redSwitch: UISwitch!
    @IBOutlet var ViewTwo: UIView!
    
    @IBOutlet weak var greenSwitch: UISwitch!
    @IBOutlet weak var blueSwitch: UISwitch!
   
    @IBOutlet weak var opacitySlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        opacitySlider.isContinuous = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Lightswitch(_ sender: UISwitch) {
        var redVal = 0
        var greenVal = 0
        var blueVal = 0
        if (redSwitch.isOn){
            redVal = 255
        }
        if (!redSwitch.isOn){
            redVal = 0
        }
        if (greenSwitch.isOn){
            greenVal = 255
        }
        if (!greenSwitch.isOn){
            greenVal = 0
        }
        if (blueSwitch.isOn){
            blueVal = 255
        }
        if (!blueSwitch.isOn){
            blueVal = 0
        }
        ViewTwo.backgroundColor = UIColor(red: CGFloat(redVal/255), green: CGFloat(greenVal/255), blue: CGFloat(blueVal/255), alpha: 1.0)
        if (!redSwitch.isOn && !greenSwitch.isOn && !blueSwitch.isOn || opacitySlider.value < 0.15)
        {
            blueLabel.textColor = .white
            greenLabel.textColor = .white
            redLabel.textColor = .white
            opacityLabel.textColor = .white
        }
        else{
            blueLabel.textColor = .black
            greenLabel.textColor = .black
            redLabel.textColor = .black
            opacityLabel.textColor = .black
        }
        ViewTwo.backgroundColor = ViewTwo.backgroundColor?.withAlphaComponent(CGFloat(opacitySlider.value))
        	
    }


    @IBAction func changeOpacity(_ sender: UISlider) {
        ViewTwo.backgroundColor = ViewTwo.backgroundColor?.withAlphaComponent(CGFloat(opacitySlider.value))
        if (opacitySlider.value < 0.15){
            blueLabel.textColor = .white
            greenLabel.textColor = .white
            redLabel.textColor = .white
            opacityLabel.textColor = .white
        }
        else{
            blueLabel.textColor = .black
            greenLabel.textColor = .black
            redLabel.textColor = .black
            opacityLabel.textColor = .black
        }
        
        
    }
}

