//
//  QuestionListViewController.swift
//  Project2
//
//  Created by user180084 on 12/13/20.
//

import UIKit
import CoreData
class QuestionListViewController: UIViewController {

    @IBOutlet weak var QuestionListTableView: UITableView!
    var myQuestions: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        QuestionListTableView.delegate = self;
        QuestionListTableView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Level1Questions")
        
        do {
            myQuestions = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("could not fetch. \(error), \(error.userInfo)")
        }
    }

    @IBAction func addQuestion(_ sender: Any) {
        let alert = UIAlertController(title: "New Question",                                            message: "Add a new Question" ,
                                      preferredStyle: .alert)
        
        alert.addTextField{(newQuestion) in
            newQuestion.text = ""
            newQuestion.placeholder = "New Question"
            
        }
        alert.addTextField{(correctAnswer) in
            correctAnswer.text = ""
            correctAnswer.placeholder = "Correct Answer"
            
        }
        alert.addTextField{(wrongAnswer1) in
            wrongAnswer1.text = ""
            wrongAnswer1.placeholder = "Wrong Answer"
            
        }
        alert.addTextField{(wrongAnswer2) in
            wrongAnswer2.text = ""
            wrongAnswer2.placeholder = "Wrong Answer"
            
        }
        alert.addTextField{(wrongAnswer3) in
            wrongAnswer3.text = ""
            wrongAnswer3.placeholder = "Wrong Answer"
            
        }
       
        let saveAction = UIAlertAction(title: "Save", style: .default) {[unowned self] _ in
            let questionText = alert.textFields![0].text
            let correctAnswer = alert.textFields![1].text
            let wrongAnswer1 = alert.textFields![2].text
            let wrongAnswer2 = alert.textFields![3].text
            let wrongAnswer3 = alert.textFields![4].text
            storeQuestion(question: Question(
                            QuestionString: questionText ?? "default", correctAnswer: correctAnswer ?? "default", wrongAnswer1: wrongAnswer1 ?? "default",  wrongAnswer2: wrongAnswer2 ?? "default", wrongAnswer3: wrongAnswer3 ?? "default"))
            QuestionListTableView.reloadData();
        }
        
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel)
        
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true);
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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

}

extension QuestionListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myQuestions.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowQuestion = myQuestions[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionCell;
        let questionString = rowQuestion.value(forKey: "questionText") as! String;
        cell.setQuestion(thisQuestion: questionString);
        
        return cell;
    }
}
