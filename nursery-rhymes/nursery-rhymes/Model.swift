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
    var rhymes = [[String: String]]()
    
    var player: AVAudioPlayer?
    
    init() {
        jsonModel = String()
        collections["Volland"] = [String: String]()
        player = AVAudioPlayer()

        readJSONModel()
    }
    
    func readJSONModel() {
        if let path = Bundle.main.path(forResource: "rhymeText", ofType: "json")//, inDirectory: "Rhyme_packs")
        {
            do {
                let txtData = try String(contentsOfFile: path, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                jsonModel = try JSONSerialization.jsonObject(with: txtData.data(using: .utf8)!)
                rhymes = (jsonModel as! [[String:String]])
                //print(rhymes)
            } catch let error {
                print(error)
            }
        } else {
            print("File not found: rhymeText.json")
        }
    }
    
    func readFileNameList() {
        if let path = Bundle.main.path(forResource: "FileNames", ofType: "txt")
        {
            do {
                let txtData = try String(contentsOfFile: path, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                for fileName in txtData.characters.split(separator: "\n") {
                    var line = String(fileName)
                    let end = line.index(line.endIndex, offsetBy: -4)
                    line = line.substring(to: end)
                    self.fileNameList.append(String(line))
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            print("File not found: FileNames.txt")
        }
    }
    
    func getRhymeText(rawText: String) -> String {
        var result = String()
        
        let lines = rawText.characters.split(separator: "\n")
        for line in lines {
            let words = line.split(separator: " ")
            
            var word = String(words[1])
            let end = word.index(word.endIndex, offsetBy: -1)
            word = word.substring(to: end)
            result.append(word)
            result.append(" ")
        }
        return result
    }
    
    func getRhymeName(id: Int) -> String {
        return rhymes[id]["title"]!
    }
    
    func getRhymeText(id: Int) -> String {
        return rhymes[id]["text"]!
    }
    
    func getRhymeTranscript(id: Int) -> String {
        let filename = rhymes[id]["title"]! + rhymes[id]["collection"]!
        
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
            print("File not found: transcripts/"+filename+".transcript")
        }
        
        return String()
    }
    
    func getRhymeAudio(id: Int) -> AVAudioPlayer {
        let filename = rhymes[id]["title"]! + rhymes[id]["collection"]!
        
        if let url = Bundle.main.url(forResource: filename, withExtension: "mp3", subdirectory: "rhyme_files")
        {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                self.player = try AVAudioPlayer(contentsOf: url)
                return self.player!
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("File not found: transcripts/"+filename+".jpg")
        }
        
        print("Audio player error for rhyme_files/\(filename).mp3")
        return self.player!
    }
    
    func getRhymeImage(id: Int) -> UIImage {
        let filename = rhymes[id]["title"]! + rhymes[id]["collection"]!
        
        if let path = Bundle.main.path(forResource: filename, ofType: "jpg", inDirectory: "rhyme_files")
        {
            return UIImage(contentsOfFile: path)!
        } else {
            print("File not found: transcripts/"+filename+".jpg")
        }
        
        return UIImage(named: "pandaprofile.png")!;
    }
    
    func getRhymeCollection(id: Int) -> String {
        return rhymes[id]["collection"]!
    }
    
    static func getModel() -> Model {
        return Model.model
    }
}
