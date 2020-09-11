//
//  HomeView.swift
//  Assignment1
//
//  Created by user180084 on 9/10/20.
//  Copyright © 2020 WesleyWong. All rights reserved.
//

import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    
    @IBOutlet weak var stressBar: UIProgressView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var timerTest : Timer?
    var timeLeft = 10.0;
    var inGame = false;
    var nextButton = 1;
    var Score = 0;
    var highScore = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.isHidden = true
        buttonTwo.isEnabled = false
        buttonTwo.isHidden = true
        buttonThree.isEnabled = false
        buttonThree.isHidden = true
        buttonFour.isEnabled = false
        buttonFour.isHidden = true
        stressBar.transform = stressBar.transform.scaledBy(x: 1, y: 5)
        
        // Do any additional setup after loading the view.
    }

    func startTimer() {
        guard timerTest == nil else {return}
        timerTest = Timer.scheduledTimer(
            timeInterval: TimeInterval(0.1),
            target : self,
            selector : #selector(HomeView.countdown),
            userInfo : nil,
            repeats : true)
    }
    @objc func countdown() {
        timeLeft = timeLeft - timerTest!.timeInterval
        stressBar.progress = Float(timeLeft/10.0);
        if (timeLeft <= 0.0 && inGame) {
            stopTimer()
            gameOver();
        }
        else if (timeLeft <= 0.0 && !inGame)
        {
            stopTimer();
            enableRestart();
        }
    }
    
    func stopTimer() {
        timerTest?.invalidate()
        timerTest = nil
    }
    
    func gameOver() {
        messageLabel.text = "Game Over, Final Score: \(Score)"
        messageLabel.isHidden = false
        ScoreLabel.text = "Press 1 to play again"
        if (Score > highScore)
        {
            highScore = Score
        }
        
        Score = 0;
        inGame = false
                   
        buttonOne.isEnabled = false
        buttonOne.isHidden = true
        buttonTwo.isEnabled = false
        buttonTwo.isHidden = true
        buttonThree.isEnabled = false
        buttonThree.isHidden = true
        buttonFour.isEnabled = false
        buttonFour.isHidden = true
        
        timeLeft = 5;
        startTimer();
        
        
    }
    func enableRestart()
    {
        timeLeft = 10.0
        buttonOne.isEnabled = true
        buttonOne.isHidden = false
        buttonTwo.isEnabled = false
        buttonTwo.isHidden = true
        buttonThree.isEnabled = false
        buttonThree.isHidden = true
        buttonFour.isEnabled = false
        buttonFour.isHidden = true
    }
    
    @IBAction func gameStart(_ sender: UIButton) {
        if (!inGame)
        {
            inGame = true
            messageLabel.isHidden = true
            ScoreLabel.text = "Score: \(Score)"
            nextButton = Int.random(in: 1..<5)
            turnOnButton(buttonNum:nextButton)
            startTimer()
        }
    }
    
    @IBAction func GameLoop(_ sender: UIButton) {
        if (inGame)
        {
            Score+=1
            ScoreLabel.text = "Score: \(Score)"
            nextButton = Int.random(in: 1..<5)
            
            turnOnButton(buttonNum:nextButton)
            
            timeLeft = Double(10 - (Score / 10))
            if (timeLeft < 0.3)
            {
                timeLeft = 0.3
            }
            
        }
    }
    
    func turnOnButton(buttonNum: Int)
    {
        switch buttonNum{
        case 1:
            buttonOne.isEnabled = true
            buttonOne.isHidden = false
            buttonTwo.isEnabled = false
            buttonTwo.isHidden = true
            buttonThree.isEnabled = false
            buttonThree.isHidden = true
            buttonFour.isEnabled = false
            buttonFour.isHidden = true
            break;
            
        case 2:
            buttonOne.isEnabled = false
            buttonOne.isHidden = true
            buttonTwo.isEnabled = true
            buttonTwo.isHidden = false
            buttonThree.isEnabled = false
            buttonThree.isHidden = true
            buttonFour.isEnabled = false
            buttonFour.isHidden = true
            break;
        case 3:
            buttonOne.isEnabled = false
            buttonOne.isHidden = true
            buttonTwo.isEnabled = false
            buttonTwo.isHidden = true
            buttonThree.isEnabled = true
            buttonThree.isHidden = false
            buttonFour.isEnabled = false
            buttonFour.isHidden = true
            break;
        case 4:
            buttonOne.isEnabled = false
            buttonOne.isHidden = true
            buttonTwo.isEnabled = false
            buttonTwo.isHidden = true
            buttonThree.isEnabled = false
            buttonThree.isHidden = true
            buttonFour.isEnabled = true
            buttonFour.isHidden = false
            break;
        default:
            ScoreLabel.text = "Error"
            break;
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
	
