//
//  Model.swift
//  nursery-rhymes
//
//  Created by Guest on 12/31/00.
//  Copyright © 2000 Team8343. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreData

class Model {
    static var model: Model = Model()
   
    var jsonModel: Any
    var collections = [String: [String: String]]()
    var fileNameList = [String]()
    var rhymes = [Int: [String: String]]()
    
    var audioContainer = AudioContainer()
    var highlightingContainer = HighlightingContainer()
    var quizzes = [[String: String]]()
    var quizJson: Any
    var coreData = CoreDataContainer()
  
    
    init() {
       
        quizJson = String()
        jsonModel = String()
        collections["Volland"] = [String: String]()
        readJSONModel()
        readQuizzesJson()
    }
    
    func readJSONModel() {
        if let path = Bundle.main.path(forResource: "rhymeText", ofType: "json")        {
            do {
                let txtData = try String(contentsOfFile: path, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                jsonModel = try JSONSerialization.jsonObject(with: txtData.data(using: .utf8)!)
                let rhymesData = (jsonModel as! [[String:String]])
                
                rhymes = [Int: [String:String]]();
                for (_, rhyme) in rhymesData.enumerated() {
                    let rhymeId = Int(rhyme["id"]!)
                    rhymes[rhymeId!] = rhyme
                }
                
            } catch let error {
                print(error)
            }
        } else {
            print("File not found: rhymeText.json")
        }
    }
    
    func getRhymeFileName(id: Int) -> String {
        return getRhymeName(id: id) + getRhymeCollection(id: id)
    }

    func getRhymeName(id: Int) -> String {
        return rhymes[id]?["title"]! ?? ""
    }
    
    func getRhymeText(id: Int) -> String {
        return rhymes[id]?["text"]! ?? ""
    }
    
    func getRhymeTranscript(id: Int) -> String {
        let filename = getRhymeFileName(id: id)
        
        if let path = Bundle.main.path(forResource: filename, ofType: "transcript", inDirectory: "rhyme_files")
        {
            do {
                let txtData = try String(contentsOfFile: path, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                //self.collections[collectionName]?[fileName] = txtData
                return txtData
            } catch let error as NSError {
                print(error)
            }
        } else {
            print("File not found: rhyme_files/"+filename+".transcript")
        }
        
        return ""
    }
    
    func getRhymeImage(id: Int) -> UIImage {
        let filename = getRhymeFileName(id: id)
        
        if let path = Bundle.main.path(forResource: filename, ofType: "jpg", inDirectory: "rhyme_files")
        {
            return UIImage(contentsOfFile: path)!
        } else {
            print("File not found: rhyme_files/"+filename+".jpg")
        }
        
        return UIImage(named: "pandaprofile.png")!;
    }
    
    func getRhymeCollection(id: Int) -> String {
        let collectionName =  rhymes[id]?["collection"]
        return collectionName ?? ""
    }
    
    func readQuizzesJson() {
        if let path = Bundle.main.path(forResource: "quizDatabaseV2", ofType: "json")
        {
            do {
                let txtData = try String(contentsOfFile: path, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                quizJson = try JSONSerialization.jsonObject(with: txtData.data(using: .utf8)!)
                quizzes = (quizJson as! [[String:String]])
                //print("in rhyme json \(quizzes)")
            } catch let error {
                print(error)
            }
        } else {
            print("File not found: rhymeText.json")
        }
    }
    
    //Takes in rhyme name
    //Returns array with All Questions, 4 answer choices per question, with every i = 4 being the correct answer
    func getQuiz(rhyme: Int, level: Int) -> [String:String] {
        
        let stringRhyme = String(rhyme)
        // minus 1 since it originally started at 1, now json starts at 0.
        let stringLevel = String(1 - level)
        print("\(level)")
        var rhymeQuiz: [String: String] = [:]
        for quiz in quizzes {
            print("quizID \(quiz["RhymeID"]!) Equals \(stringRhyme) Question \(quiz["QuestionNo"]!) Equals \(level)")
            if (quiz["RhymeID"] == stringRhyme && quiz["QuestionNo"] == stringLevel) {
                rhymeQuiz = quiz
                print("inside \(stringRhyme)")
            }
        }
        print("\(rhymeQuiz)")
        return rhymeQuiz
    }
    
    func getRhymesForCollection(collectionName: String) ->[Int: [String: String]] {
        var tempRhymes = [Int: [String: String]]()
        let validRhymeIds = Array(self.rhymes.keys).filter { (key: Int) -> Bool in
            return self.rhymes[key]?["collection"] == collectionName
        }
        for key in validRhymeIds {
            tempRhymes[key] = self.rhymes[key]
        }
        
        return tempRhymes
    }
    
    static func getModel() -> Model {
        return Model.model
    }
    
    func getHomeExFilename(rhymeId: Int, homeExId: Int) -> String {
        var filename = getRhymeFileName(id: rhymeId)
        filename = filename + "HE" + String(homeExId)
        //print("HOME \(filename)")
        
        if Bundle.main.url(forResource: filename, withExtension: "mp3", subdirectory: "rhyme_files") != nil {
            return filename
        } else {
            return ""
        }
    }
    
    func getHomeExCount(id: Int) -> Int {
        var index = 1
        var homeExCount = 0
        while (index != 0) {
            let homeExFilename = getHomeExFilename(rhymeId: id, homeExId: index)
            if (homeExFilename == "") {
                //End loop
                homeExCount = index - 1
                index = 0
            } else {
                index = index + 1
            }
        }
        return homeExCount
    }
}
