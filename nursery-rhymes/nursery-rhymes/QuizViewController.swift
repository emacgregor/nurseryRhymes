//
//  QuizViewController.swift
//  nursery-rhymes
//
//  Created by Zachary Cheshire on 1/20/19.
//  Copyright © 2019 Team8343. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class QuizViewController : UIViewController {
    @IBOutlet weak var score: UILabel!
    var quizzes: [String: String] = [:]
    var m = Model()
    var id = Int()
    var message = String()
    var level = 1
    var count = 0
    var jsonModel  = String()
  
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var labelA: RoundButton!
    @IBOutlet weak var labelB: RoundButton!
    @IBOutlet weak var labelC: RoundButton!
    @IBOutlet weak var labelD: RoundButton!
    
    override func viewDidLoad() {
        m = Model.getModel()
        //saveData(key: "dic", value: "bill")
        //getData(key: "dic")
        
        level = getCurrentLevel(key: String(id)) ?? 0
        
        score.text = "\(count) / 4"
        
        print("message \(message)")
        
        self.navigationItem.title = self.message;
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        questionLabel.text = quizzes["QuestionText"]
        print(quizzes)
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
    }

    func getCurrentLevel(key: String) -> Int? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Quiz")
        let predicate = NSPredicate(format: "rhymeId = %@", String(self.id))
        fetchRequest.predicate = predicate
        do {
            let currentLevel = try managedContext.fetch(fetchRequest).first?.value(forKeyPath: "question")
            print("CurrentLevel: \(currentLevel ?? "--")")
            return currentLevel as? Int
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func saveCurrentLevel() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Quiz")
        fetchRequest.predicate = NSPredicate(format: "rhymeId = %@", String(self.id))
        do {
            if let quiz = try managedContext.fetch(fetchRequest).first {
                quiz.setValue(self.level, forKeyPath: "question")
                print("Updating \(self.id)")
                try managedContext.save()
            } else {
                let entity = NSEntityDescription.entity(forEntityName: "Quiz",
                                                        in: managedContext)!
                let quiz = NSManagedObject(entity: entity,
                                           insertInto: managedContext)
                quiz.setValue(self.id, forKeyPath: "rhymeId")
                quiz.setValue(self.level, forKeyPath: "question")
                try managedContext.save()
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func answerA(_ sender: Any) {
        level = level + 1
        if labelA.titleLabel!.text == quizzes["Answer"]! {
            count = count + 1
            score.text = "\(count) / 4"
        }
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        saveCurrentLevel()
        print(quizzes["Answer"])
        print(labelA.titleLabel!.text)
        questionLabel.text = quizzes["QuestionText"]
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
     
        
        
    }
    
    @IBAction func answerB(_ sender: Any) {
        level = level + 1
        if labelB.titleLabel?.text == quizzes["Answer"] {
            count = count + 1
            score.text = "\(count) / 4"
            
        }
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        saveCurrentLevel()
        questionLabel.text = quizzes["QuestionText"]
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
      
        
    }
    
    @IBAction func answerC(_ sender: Any) {
        level = level + 1
        if labelC.titleLabel?.text == quizzes["Answer"] {
            count = count + 1
            score.text = "\(count) / 4"
            
        }
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        saveCurrentLevel()
        questionLabel.text = quizzes["QuestionText"]
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
      

        
    }
    
    @IBAction func answerD(_ sender: Any) {
        level = level + 1
        if labelD.titleLabel?.text == quizzes["Answer"] {
            count = count + 1
            score.text = "\(count) / 4"
            
        }
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        saveCurrentLevel()
        questionLabel.text = quizzes["QuestionText"]
        labelA.setTitle(quizzes["A"], for: .normal)
        labelA.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: [])
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
    }
}

