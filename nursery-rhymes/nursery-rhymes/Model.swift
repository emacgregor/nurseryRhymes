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
    
    var collections: [[String]]
    
    init() {
        collections = [[]]
        
    }
    
    func readFile(fileName: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt")
        {
            print(path)
            do {
                let txtData = try String(contentsOfFile: path, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                self.collections[0][0] = txtData
                //print(txtData)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    static func getModel() -> Model {
        return Model.model
    }
}
