//
//  Model.swift
//  nursery-rhymes
//
//  Created by Guest on 12/31/00.
//  Copyright © 2000 Team8343. All rights reserved.
//

import Foundation

class Model {
    static var model: Model = Model()
    
    var collections: [String: [String: String]]
    var fileNameList: [String]
    
    init() {
        collections = [String: [String: String]]()
        collections["Volland"] = [String: String]()
        print("hello")
        fileNameList = [String]()
        print("I'm here")
        readFileNameList()
        print("How are you?")
        for fileName in self.fileNameList {
            print(fileName)
            readFile(fileName: fileName, collectionName: "Volland")
        }
        print("I'm doing fine")
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
    
    func readFile(fileName: String, collectionName: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt", inDirectory: "transcripts")
        {
            //print(path)
            do {
                let txtData = try String(contentsOfFile: path, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                self.collections[collectionName]?[fileName] = txtData
                //print(txtData)
            } catch let error as NSError {
                print(error)
            }
        } else {
            print("File not found: transcripts/"+fileName+".txt")
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
    
    func getRhymeName(fileName: String) -> String {
        let splitted = fileName.characters.split(separator: "_")
        let result = splitted[splitted.count - 1]
        
        //This is just for my testing, sorry if I forgot to comment it out -Ethan
        //return fileName
        return String(result)
    }
    
    static func getModel() -> Model {
        print ("how do you do")
        return Model.model
    }
}
