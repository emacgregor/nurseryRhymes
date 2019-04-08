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
        if let path = Bundle.main.path(forResource: "rhymeText", ofType: "json")        {
            do {
                let txtData = try String(contentsOfFile: path, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                jsonModel = try JSONSerialization.jsonObject(with: txtData.data(using: .utf8)!)
                rhymes = (jsonModel as! [[String:String]])
            } catch let error {
                print(error)
            }
        } else {
            print("File not found: rhymeText.json")
        }
    }
    
    func getRhymeFileName(id: Int) -> String {
        var collectionName =  rhymes[id]["collection"]!
        if (collectionName == "Father Goose Visit") {
            collectionName = "FGV"
        } else if (collectionName == "Mother Goose Visit") {
            collectionName = "MGV"
        }
        return rhymes[id]["title"]! + collectionName
    }

    func getRhymeName(id: Int) -> String {
        return rhymes[id]["title"]!
    }
    
    func getRhymeText(id: Int) -> String {
        return rhymes[id]["text"]!
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
    
    func getRhymeAudio(id: Int) -> AVAudioPlayer {
        let filename = getRhymeFileName(id: id)
        
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
            print("File not found: rhyme_files/"+filename+".jpg")
        }
        
        print("Audio player error for rhyme_files/\(filename).mp3")
        return self.player!
    }
    func getHomeExAudio(rhymeId: Int, homeExId: Int) -> AVAudioPlayer? {
        var filename = getRhymeFileName(id: rhymeId)
        filename = filename + "HE" + String(homeExId)
        
        if let url = Bundle.main.url(forResource: filename, withExtension: "mp3", subdirectory: "rhyme_files")
        {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                self.player = try AVAudioPlayer(contentsOf: url)
                return self.player
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("File not found: rhyme_files/"+filename+".mp3")
        }
        
        return nil
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
        return rhymes[id]["collection"]!
    }
    
    func getRhymesForCollection(collectionName: String) ->[[String: String]] {
        var tempRhymes = self.rhymes
        tempRhymes = tempRhymes.filter { (rhyme: [String : String]) -> Bool in
            return rhyme["collection"] == collectionName
        }
        return tempRhymes
    }
    /*
     This is to be used by the future team that adds analytics to the app once the database is ready for it.
     
     func submitAction(event) {
     
     //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
     //These are what a future team needs to update.
     let parameters = ["student": "5ca4f207b9cc5e1f7c944785",
     "program": "5ca4efc7b9cc5e1f7c944784",
     "focus_item":"",
     "correct_on": 1,
     "time_spent": 0]
     
     //create the url with URL
     //This is the post request for dealing with
     let url = URL(string: "https://teacherportal.hearatale.com/api/analytics/application")!
     
     //create the session object
     let session = URLSession.shared
     
     //now create the URLRequest object using the url object
     var request = URLRequest(url: url)
     request.httpMethod = "POST" //set http method as POST
     
     do {
     request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
     } catch let error {
     print(error.localizedDescription)
     }
     
     //This is the authorization value for the test teacher of our application.
     request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjYTRlZDI1YjljYzVlMWY3Yzk0NDc4MyIsInR5cGUiOiJ0ZWFjaGVyIiwiaWF0IjoxNTU0MzEyNjU4fQ.LcPAhGDtkArvbfElXFjrhFl3vOyXX5fa3zUxPrvcn5U", forHTTPHeaderField: "Authorization")
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     request.addValue("application/json", forHTTPHeaderField: "Accept")
     
     //create dataTask using the session object to send data to the server
     let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
     
     guard error == nil else {
     return
     }
     
     guard let data = data else {
     return
     }
     
     do {
     //create json object from data
     if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
     print(json)
     // handle json...
     }
     } catch let error {
     print(error.localizedDescription)
     }
     })
     task.resume()
     }

     */
    
    static func getModel() -> Model {
        return Model.model
    }
}
