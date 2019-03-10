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

class Model {
    static var model: Model = Model()
    
    var jsonModel: Any
    var collections = [String: [String: String]]()
    var fileNameList = [String]()
    var rhymes = [Int: [String: String]]()
    
    var audioContainer = AudioContainer()
    var highlightingContainer = HighlightingContainer()
    
    init() {
        jsonModel = String()
        collections["Volland"] = [String: String]()
        readJSONModel()
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
        
        return String()
    }
    
    func getHomeExFilename(rhymeId: Int, homeExId: Int) -> String {
        var filename = getRhymeFileName(id: rhymeId)
        filename = filename + "HE" + String(homeExId)
        
        if Bundle.main.url(forResource: filename, withExtension: "mp3", subdirectory: "rhyme_files") != nil {
            return filename
        } else {
            return ""
        }
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
        var collectionName =  rhymes[id]?["collection"]!
        if (collectionName == "Father Goose Visit") {
            collectionName = "FGV"
        } else if (collectionName == "Mother Goose Visit") {
            collectionName = "MGV"
        }
        return collectionName ?? ""
    }
    
    func getRhymesForCollection(collectionName: String) ->[Int: [String: String]] {
        var tempRhymes = [Int: [String: String]]()
        //tempRhymes = tempRhymes.filter { (rhyme: [String : String]) -> Bool inreturn
            //rhyme["collection"] == collectionName
        //}
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
}
