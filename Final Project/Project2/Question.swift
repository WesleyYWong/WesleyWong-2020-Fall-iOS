//
//  Question.swift
//  Project2
//
//  Created by user180084 on 12/13/20.
//

import Foundation

class Question {
    
    var QuestionString: String;
    var correctAnswer: String;
    var wrongAnswer1: String;
    var wrongAnswer2: String;
    var wrongAnswer3: String;
    var wrongAnswerList: [String] = [];
    
    init(QuestionString: String, correctAnswer: String, wrongAnswer1:String, wrongAnswer2:String, wrongAnswer3:String)
    {
        self.QuestionString = QuestionString
        self.correctAnswer = correctAnswer
        self.wrongAnswer1 = wrongAnswer1
        self.wrongAnswer2 = wrongAnswer2
        self.wrongAnswer3 = wrongAnswer3
        wrongAnswerList.append(wrongAnswer1);
        wrongAnswerList.append(wrongAnswer2);
        wrongAnswerList.append(wrongAnswer3);
    }

    
}
