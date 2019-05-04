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
    var level = 0
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
        
        level = 0
        count = 0
        if (level > 3) {
            level = 0
            count = 0
        }
        
        score.text = "\(count * 25) / 100"
        
        print("message \(message)")
        
        self.navigationItem.title = self.message;
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
       
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        print("curlevel\(level)")
        questionLabel.text = quizzes["QuestionText"]
        print("Quiza\(quizzes)")
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
        
        var imageA = UIImage(named: "\(quizzes["A"]!).jpg") as UIImage?
        print("\(quizzes["A"]!).jpg")
        if (imageA == nil) {
            imageA = UIImage(named: "\(quizzes["A"]!).png") as UIImage?
            if (imageA == nil) {
                print("I had to use a blank")
                imageA = UIImage(named: "blank-white.jpg") as UIImage?
                print(imageA)
            }
        }
        labelA.setBackgroundImage(imageA, for: .normal)
        var imageB = UIImage(named: "\(quizzes["B"]!).jpg") as UIImage?
        if (imageB == nil) {
            imageB = UIImage(named: "\(quizzes["B"]!).png") as UIImage?
            if (imageB == nil) {
                imageB = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelB.setBackgroundImage(imageB, for: .normal)
        var imageC = UIImage(named: "\(quizzes["C"]!).jpg") as UIImage?
        if (imageC == nil) {
            imageC = UIImage(named: "\(quizzes["C"]!).png") as UIImage?
            if (imageC == nil) {
                imageC = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelC.setBackgroundImage(imageC, for: .normal)
        var imageD = UIImage(named: "\(quizzes["D"]!).jpg") as UIImage?
        if (imageD == nil) {
            imageD = UIImage(named: "\(quizzes["D"]!).png") as UIImage?
            if (imageD == nil) {
                imageD = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelD.setBackgroundImage(imageD, for: .normal)
    }

  
    
   
    
    @IBAction func answerA(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        if labelA.titleLabel!.text == quizzes["Answer"]! {
            count = count + 1
            var scoreAdded = m.coreData.getScore() ?? 0
            scoreAdded = scoreAdded + 1
            m.coreData.saveScore(score: scoreAdded)
        }
        m.coreData.saveCurrentScore(id: self.id, score: self.count)
        level = level + 1
        if (level > 3) {
            level = 0
            count = 0
            
        }
        score.text = "\(count * 25) / 100"
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        m.coreData.saveCurrentLevel(id: self.id, level: self.level)
        print(quizzes["Answer"])
        print(labelA.titleLabel!.text)
        questionLabel.text = quizzes["QuestionText"]!
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
        
        var imageA = UIImage(named: "\(quizzes["A"]!).jpg") as UIImage?
        print("\(quizzes["A"]!).jpg")
        if (imageA == nil) {
            imageA = UIImage(named: "\(quizzes["A"]!).png") as UIImage?
            if (imageA == nil) {
                print("I had to use a blank")
                imageA = UIImage(named: "blank-white.jpg") as UIImage?
                print(imageA)
            }
        }
        labelA.setBackgroundImage(imageA, for: .normal)
        var imageB = UIImage(named: "\(quizzes["B"]!).jpg") as UIImage?
        if (imageB == nil) {
            imageB = UIImage(named: "\(quizzes["B"]!).png") as UIImage?
            if (imageB == nil) {
                imageB = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelB.setBackgroundImage(imageB, for: .normal)
        var imageC = UIImage(named: "\(quizzes["C"]!).jpg") as UIImage?
        if (imageC == nil) {
            imageC = UIImage(named: "\(quizzes["C"]!).png") as UIImage?
            if (imageC == nil) {
                imageC = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelC.setBackgroundImage(imageC, for: .normal)
        var imageD = UIImage(named: "\(quizzes["D"]!).jpg") as UIImage?
        if (imageD == nil) {
            imageD = UIImage(named: "\(quizzes["D"]!).png") as UIImage?
            if (imageD == nil) {
                imageD = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelD.setBackgroundImage(imageD, for: .normal)
    }
        

    
    
    @IBAction func answerB(_ sender: Any) {
        
        if labelB.titleLabel!.text == quizzes["Answer"]! {
            count = count + 1
            score.text = "\(count * 25) / 100"
            var scoreAdded = m.coreData.getScore() ?? 0
            scoreAdded = scoreAdded + 1
            m.coreData.saveScore(score: scoreAdded)
            
        }
        m.coreData.saveCurrentScore(id: self.id, score: self.count)
        level = level + 1
        if (level > 3) {
            level = 0
            count = 0
            
        }
        
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        score.text = "\(count * 25) / 100"
        m.coreData.saveCurrentLevel(id: self.id, level: self.level)
        questionLabel.text = quizzes["QuestionText"]!
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
       
        var imageA = UIImage(named: "\(quizzes["A"]!).jpg") as UIImage?
        print("\(quizzes["A"]!).jpg")
        if (imageA == nil) {
            imageA = UIImage(named: "\(quizzes["A"]!).png") as UIImage?
            if (imageA == nil) {
                print("I had to use a blank")
                imageA = UIImage(named: "blank-white.jpg") as UIImage?
                print(imageA)
            }
        }
        labelA.setBackgroundImage(imageA, for: .normal)
        var imageB = UIImage(named: "\(quizzes["B"]!).jpg") as UIImage?
        if (imageB == nil) {
            imageB = UIImage(named: "\(quizzes["B"]!).png") as UIImage?
            if (imageB == nil) {
                imageB = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelB.setBackgroundImage(imageB, for: .normal)
        var imageC = UIImage(named: "\(quizzes["C"]!).jpg") as UIImage?
        if (imageC == nil) {
            imageC = UIImage(named: "\(quizzes["C"]!).png") as UIImage?
            if (imageC == nil) {
                imageC = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelC.setBackgroundImage(imageC, for: .normal)
        var imageD = UIImage(named: "\(quizzes["D"]!).jpg") as UIImage?
        if (imageD == nil) {
            imageD = UIImage(named: "\(quizzes["D"]!).png") as UIImage?
            if (imageD == nil) {
                imageD = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelD.setBackgroundImage(imageD, for: .normal)
    }
      

    
    @IBAction func answerC(_ sender: Any) {
        if labelC.titleLabel!.text == quizzes["Answer"]! {
            count = count + 1
            score.text = "\(count * 25) / 100"
            var scoreAdded = m.coreData.getScore() ?? 0
            scoreAdded = scoreAdded + 1
            m.coreData.saveScore(score: scoreAdded)
        }
        m.coreData.saveCurrentScore(id: self.id, score: self.count)
        level = level + 1
        if (level > 3) {
            level = 0
            count = 0
            
        }
        score.text = "\(count * 25) / 100"

        quizzes = m.getQuiz(rhyme: self.id, level: level)
        m.coreData.saveCurrentLevel(id: self.id, level: self.level)
        questionLabel.text = quizzes["QuestionText"]!
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
        
        var imageA = UIImage(named: "\(quizzes["A"]!).jpg") as UIImage?
        print("\(quizzes["A"]!).jpg")
        if (imageA == nil) {
            imageA = UIImage(named: "\(quizzes["A"]!).png") as UIImage?
            if (imageA == nil) {
                print("I had to use a blank")
                imageA = UIImage(named: "blank-white.jpg") as UIImage?
                print(imageA)
            }
        }
        labelA.setBackgroundImage(imageA, for: .normal)
        var imageB = UIImage(named: "\(quizzes["B"]!).jpg") as UIImage?
        if (imageB == nil) {
            imageB = UIImage(named: "\(quizzes["B"]!).png") as UIImage?
            if (imageB == nil) {
                imageB = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelB.setBackgroundImage(imageB, for: .normal)
        var imageC = UIImage(named: "\(quizzes["C"]!).jpg") as UIImage?
        if (imageC == nil) {
            imageC = UIImage(named: "\(quizzes["C"]!).png") as UIImage?
            if (imageC == nil) {
                imageC = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelC.setBackgroundImage(imageC, for: .normal)
        var imageD = UIImage(named: "\(quizzes["D"]!).jpg") as UIImage?
        if (imageD == nil) {
            imageD = UIImage(named: "\(quizzes["D"]!).png") as UIImage?
            if (imageD == nil) {
                imageD = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelD.setBackgroundImage(imageD, for: .normal)
    }
      


    
    @IBAction func answerD(_ sender: Any) {
        if labelD.titleLabel!.text == quizzes["Answer"]! {
            count = count + 1
            score.text = "\(count * 25) / 100"
            var scoreAdded = m.coreData.getScore() ?? 0
            scoreAdded = scoreAdded + 1
            m.coreData.saveScore(score: scoreAdded)
        }
        m.coreData.saveCurrentScore(id: self.id, score: self.count)
        level = level + 1
        if (level > 3) {
            level = 0
            count = 0
            
        }
        score.text = "\(count * 25) / 100"
        
        quizzes = m.getQuiz(rhyme: self.id, level: level)
        m.coreData.saveCurrentLevel(id: self.id, level: self.level)
        questionLabel.text = quizzes["QuestionText"]!
        labelA.setTitle(quizzes["A"], for: .normal)
        labelB.setTitle(quizzes["B"], for: .normal)
        labelC.setTitle(quizzes["C"], for: .normal)
        labelD.setTitle(quizzes["D"], for: .normal)
        
        var imageA = UIImage(named: "\(quizzes["A"]!).jpg") as UIImage?
        print("\(quizzes["A"]!).jpg")
        if (imageA == nil) {
            imageA = UIImage(named: "\(quizzes["A"]!).png") as UIImage?
            if (imageA == nil) {
                print("I had to use a blank")
                imageA = UIImage(named: "blank-white.jpg") as UIImage?
                print(imageA)
            }
        }
        labelA.setBackgroundImage(imageA, for: .normal)
        var imageB = UIImage(named: "\(quizzes["B"]!).jpg") as UIImage?
        if (imageB == nil) {
            imageB = UIImage(named: "\(quizzes["B"]!).png") as UIImage?
            if (imageB == nil) {
                imageB = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelB.setBackgroundImage(imageB, for: .normal)
        var imageC = UIImage(named: "\(quizzes["C"]!).jpg") as UIImage?
        if (imageC == nil) {
            imageC = UIImage(named: "\(quizzes["C"]!).png") as UIImage?
            if (imageC == nil) {
                imageC = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelC.setBackgroundImage(imageC, for: .normal)
        var imageD = UIImage(named: "\(quizzes["D"]!).jpg") as UIImage?
        if (imageD == nil) {
            imageD = UIImage(named: "\(quizzes["D"]!).png") as UIImage?
            if (imageD == nil) {
                imageD = UIImage(named: "blank-white.jpg") as UIImage?
            }
        }
        labelD.setBackgroundImage(imageD, for: .normal)
    }
}

