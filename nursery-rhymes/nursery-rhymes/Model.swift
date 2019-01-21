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
    
    init() {
        collections = [String: [String: String]]()
        collections["Volland"] = [String: String]()
    }
    
    func readFile(fileName: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt")
        {
            print(path)
            do {
                let txtData = try String(contentsOfFile: path, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                self.collections["Volland"]?["Willie Boy"] = txtData
                //print(txtData)
            } catch let error as NSError {
                print(error)
            }
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
    
    static func getModel() -> Model {
        return Model.model
    }
}
