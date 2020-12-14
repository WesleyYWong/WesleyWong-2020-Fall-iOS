//
//  QuizViewController.swift
//  Project2
//
//  Created by user180084 on 12/13/20.
//

import UIKit
import CoreData


class QuizViewController: UIViewController {
   
    @IBOutlet weak var UserScoreLabel: UILabel!
    
    @IBOutlet weak var QuestionLabel: UILabel!
   
    @IBOutlet weak var Answer1: UIButton!
    @IBOutlet weak var Answer2: UIButton!
    @IBOutlet weak var Answer3: UIButton!
    @IBOutlet weak var Answer4: UIButton!
    weak var currentProfile: NSManagedObject?;
    weak var currentQuestion: NSManagedObject?;
    var defaultQuestions: [NSManagedObject] = [];
    var basicQuestions: [Question] = [];
    var answerButtonList: [UIButton] = [];
    var score = 0;
    var name = "";
    var currentQuestionNum = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeDefaultUser()
        getDefaultUser()
        defaultQuestionsInit()
        for question in basicQuestions {
            storeQuestion(question: question);
        }
        getDefaultQuestions()
        answerButtonList.append(Answer1);
        answerButtonList.append(Answer2);
        answerButtonList.append(Answer3);
        answerButtonList.append(Answer4);
       
        self.name = currentProfile?.value(forKey: "firstName") as! String;
        self.score = currentProfile?.value(forKey: "score") as! Int;
        updateLabel(
            fname: currentProfile?.value(forKey: "firstName") as! String,
            lname: currentProfile?.value(forKey: "lastName") as! String,
            Score: score)
        
        updateQuestionView(entityQ: defaultQuestions[0])
        currentQuestion = defaultQuestions[0]
        currentQuestionNum = 0;
        
        
    }
    
    @IBAction func AnswerGuessed(_ sender: UIButton) {
        if (sender.title(for: .normal) == currentQuestion?.value(forKey: "correctAnswer") as? String)
        {
            self.score = score + 1;
            updateUser(score: score, firstName: self.name);
            nextQuestion();
        }
        else {
            self.score = score - 1;
            updateUser(score: score, firstName: self.name);
        }
    }
    
    func nextQuestion() {
        currentQuestionNum = (currentQuestionNum + 1) % defaultQuestions.count;
        currentQuestion = defaultQuestions[currentQuestionNum]
        updateQuestionView(entityQ: defaultQuestions[currentQuestionNum])
    }
    
    func storeQuestion(question: Question) {
        guard let appDelete = UIApplication.shared.delegate
                as? AppDelegate  else {
            return
        }
        
        let managedContext = appDelete.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Level1Questions", in: managedContext)!
        
        let newQuestion = NSManagedObject(entity: entity, insertInto: managedContext);
        
        newQuestion.setValue(question.correctAnswer , forKey: "correctAnswer")
        newQuestion.setValue(question.QuestionString, forKey: "questionText")
        newQuestion.setValue(question.wrongAnswer1, forKey: "wrongAnswer1")
        newQuestion.setValue(question.wrongAnswer2, forKey: "wrongAnswer2")
        newQuestion.setValue(question.wrongAnswer3, forKey: "wrongAnswer3")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func defaultQuestionsInit() {
        let Question1 = Question(QuestionString: "Who is an author the US Declaration of Independence?", correctAnswer: "Thomas Jefferson", wrongAnswer1: "George Washington", wrongAnswer2: "John LaFontaine", wrongAnswer3: "Paul Revere");
        
        let Question2 = Question(QuestionString: "Which national Legislative body is composed of 100 members?", correctAnswer: "Senate", wrongAnswer1: "House", wrongAnswer2: "Supreme Court", wrongAnswer3: "Joint Terrorism Task force")
        
        let Question3 = Question(QuestionString: "What is the Capital of Idaho?", correctAnswer: "Boise", wrongAnswer1: "Idaho City", wrongAnswer2: "Coeur d'Alene", wrongAnswer3: "Twin Falls")
        
        let Question4 = Question(QuestionString: "In what year was the Biparstisn Campaign Reform Act signed into law?", correctAnswer: "2002", wrongAnswer1: "2001", wrongAnswer2: "1973", wrongAnswer3: "2010")
        
        basicQuestions.append(Question1);
        basicQuestions.append(Question2);
        basicQuestions.append(Question3);
        basicQuestions.append(Question4);
    }
    
    func updateUser(score: Int, firstName: String) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "UserProfile")
        request.predicate = NSPredicate(format: "firstName = %@", firstName)
        
        do {
            let profile = try managedContext.fetch(request)
            currentProfile = profile[0]
            currentProfile?.setValue(score, forKey: "score")
            updateLabel(
                fname: currentProfile?.value(forKey: "firstName") as! String,
                lname: currentProfile?.value(forKey: "lastName") as! String,
                Score: score)
            try managedContext.save()
        } catch let error as NSError {
            print("could not fetch. \(error), \(error.userInfo)")
        }
    }

    func storeDefaultUser() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "UserProfile", in: managedContext)!
        
        let userProfile = NSManagedObject(entity: entity, insertInto: managedContext)
        
        userProfile.setValue("Guest", forKey: "firstName");
        userProfile.setValue("Smith", forKey: "lastName");
        userProfile.setValue(0 , forKey: "score");
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func getDefaultUser() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "UserProfile")
        
        do {
            let profile = try managedContext.fetch(fetchRequest)
            currentProfile = profile[0];
        } catch let error as NSError {
            print("could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func getDefaultQuestions() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Level1Questions")
        
        do {
            self.defaultQuestions = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func updateLabel(fname:String,lname:String,Score:Int){
        self.UserScoreLabel.text = "Welcome \(fname) | Score: \(Score)"
    }
    
    func updateQuestionView(entityQ: NSManagedObject)
    {
        let newQuestion = Question(
            QuestionString: entityQ.value(forKey: "questionText") as! String,
            correctAnswer: entityQ.value(forKey: "correctAnswer") as! String,
            wrongAnswer1: entityQ.value(forKey: "wrongAnswer1") as! String,
            wrongAnswer2: entityQ.value(forKey: "wrongAnswer2") as! String,
            wrongAnswer3: entityQ.value(forKey: "wrongAnswer3") as! String)
        
        self.QuestionLabel.text = newQuestion.QuestionString;
        let number = Int.random(in: 0..<4);
        self.answerButtonList[number].setTitle(newQuestion.correctAnswer, for: .normal);
        var wrongAnswerNum = 0;
        for n in 0...3 {
            if (n != number)
            {
                self.answerButtonList[n].setTitle(newQuestion.wrongAnswerList[wrongAnswerNum], for: .normal)
                wrongAnswerNum = wrongAnswerNum + 1
                
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

}
