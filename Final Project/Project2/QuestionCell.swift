//
//  QuestionCell.swift
//  Project2
//
//  Created by user180084 on 12/13/20.
//

import UIKit

class QuestionCell: UITableViewCell {

    
    @IBOutlet weak var QuestionLabel: UILabel!
    func setQuestion(thisQuestion: String) {
        QuestionLabel.text = thisQuestion;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
