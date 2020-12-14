//
//  GetNewsViewController.swift
//  Project2
//
//  Created by user180084 on 12/13/20.
//

import UIKit

class GetNewsViewController: UIViewController {
 
    let stringToCall: String = "http://newsapi.org/v2/everything?q=idaho&from=2020-12-6&pageSize=5&apiKey=3766ee880a754f60b2dcb61ff91866d0"
    let localNewString: String = "https://news.google.com/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNRGs1ZEhrU0FtVnVLQUFQAQ?hl=en-US&gl=US&ceid=US%3Aen"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LocalNewsButton(_ sender: Any) {
        if let url = URL(string: stringToCall){
            UIApplication.shared.open(url);
            }
        }
        
    @IBAction func ReadableNewsButton(_ sender: Any) {
        if let url = URL(string: localNewString) {
            UIApplication.shared.open(url);
        }
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


