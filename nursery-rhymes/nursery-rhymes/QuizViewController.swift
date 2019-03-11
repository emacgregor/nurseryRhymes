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
  
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var labelA: RoundButton!
    @IBOutlet weak var labelB: RoundButton!
    @IBOutlet weak var labelC: RoundButton!
    @IBOutlet weak var labelD: RoundButton!
    
    override func viewDidLoad() {
        m = Model.getModel()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue("Shashikant", forKey: "rhyme")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "rhyme") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
        
        id = id + 1
        score.text = "\(count) / 4"
        
        print("message \(message)")
        
        self.navigationItem.title = self.message;
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        
        quizzes = m.getQuiz(rhyme: self.id, level: "\(level)")
        questionLabel.text = quizzes["QuestionText"]
        print(quizzes)
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
    }
    
    @IBAction func answerA(_ sender: Any) {
        level = level + 1
        if labelA.titleLabel!.text == quizzes["Answer"]! {
            count = count + 1
            score.text = "\(count) / 4"
        }
        quizzes = m.getQuiz(rhyme: self.id, level: "\(level)")
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
        quizzes = m.getQuiz(rhyme: self.id, level: "\(level)")
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
        quizzes = m.getQuiz(rhyme: self.id, level: "\(level)")
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
        quizzes = m.getQuiz(rhyme: self.id, level: "\(level)")
        questionLabel.text = quizzes["QuestionText"]
        labelA.setTitle(quizzes["A"], for: .normal)
        labelA.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: [])
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
        

        
    }
}

