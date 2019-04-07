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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        level = m.coreData.getCurrentLevel(id: String(id)) ?? 0
        count = m.coreData.getCurrentScore(id: String(id)) ?? 0

        
        score.text = "\(count * 25) / 100"
        
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

  
    
   
    
    @IBAction func answerA(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        level = level + 1
        if (level > 4) {
            level = 1
            count = -1
        }
        if labelA.titleLabel!.text == quizzes["Answer"]! {
            count = count + 1
            score.text = "\(count * 25) / 100"
        }
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        m.coreData.saveCurrentLevel(id: self.id, level: self.level)
        m.coreData.saveCurrentScore(id: self.id, score: self.count)
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
        if (level > 4) {
            level = 1
            count = -1
        }
        if labelB.titleLabel?.text == quizzes["Answer"] {
            count = count + 1
            score.text = "\(count * 25) / 100"
            
        }
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        m.coreData.saveCurrentLevel(id: self.id, level: self.level)
        m.coreData.saveCurrentScore(id: self.id, score: self.count)
        questionLabel.text = quizzes["QuestionText"]
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
      
        
    }
    
    @IBAction func answerC(_ sender: Any) {
        level = level + 1
        if (level > 4) {
            level = 1
            count = -1
        }
        if labelC.titleLabel?.text == quizzes["Answer"] {
            count = count + 1
            score.text = "\(count * 25) / 100"
            
        }
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        m.coreData.saveCurrentLevel(id: self.id, level: self.level)
        m.coreData.saveCurrentScore(id: self.id, score: self.count)
        questionLabel.text = quizzes["QuestionText"]
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
      

        
    }
    
    @IBAction func answerD(_ sender: Any) {
        level = level + 1
        if (level > 4) {
            level = 1
            count = -1
        }
        if labelD.titleLabel?.text == quizzes["Answer"] {
            count = count + 1
            score.text = "\(count * 25) / 100"
            
        }
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        m.coreData.saveCurrentLevel(id: self.id, level: self.level)
        m.coreData.saveCurrentScore(id: self.id, score: self.count)
        questionLabel.text = quizzes["QuestionText"]
        labelA.setTitle(quizzes["A"], for: .normal)
        labelA.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: [])
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
    }
}

