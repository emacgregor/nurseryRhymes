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
            let txtData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            {
                
            }
        }
    }
}
