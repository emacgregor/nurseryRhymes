//
//  FileCacheContainer.swift
//  nursery-rhymes
//
//  Created by Christopher Kevin Atkins III on 3/11/19.
//  Copyright © 2019 Team8343. All rights reserved.
//

import Foundation

class CacheFile {
    var next: Int?
    var prev: Int?
    var data: NSData?
    
    init(next: Int?, prev: Int?, data: NSData?) {
        self.next = next
        self.prev = prev
        self.data = data
    }
}

class FileCacheContainer {
    //Doubly-Linked List, move files to front when accessed
    var check: [String: [String: Int]]
    var files: [CacheFile]
    var youngest: Int?
    var oldest: Int?
    
    init() {
        self.check = [String: [String: Int]]()
        self.files = [CacheFile](repeating: CacheFile(next: nil, prev: nil, data: nil), count: 100)
    }
    
    func loadFile(filename: String, ext: String) -> NSData? {
        //Create ext field if none exists
        if (self.check[ext] == nil) {
            self.check[ext] = [String: Int]()
        }
        
        //Check if file is cached
        if (self.check[ext]![filename] != nil) {
            let fileId = self.check[ext]![filename]!
            
            return files[fileId].data
        } else {
            //Otherwise load the file from Bundle
            if let url = Bundle.main.url(forResource: filename, withExtension: ext, subdirectory: "rhyme_files")
            {
                do {
                    let data = NSData(contentsOf: url)
                    if (oldest != nil) {
                        //Reuse Oldest
                        files[oldest!].data = data
                        files[oldest!].next = nil;
                        files[oldest!].prev = youngest!
                        youngest = oldest!
                        if ((files[oldest!].next) != nil) {
                            oldest = files[oldest!].next
                        }
                    } else {
                        youngest = 0
                        oldest = 0
                        files[oldest!].data = data
                        files[oldest!].next = nil;
                        files[oldest!].prev = nil;
                    }
                    return data
                } catch let error {
                    print(error.localizedDescription)
                    return nil
                }
            } else {
                print("File not found: rhyme_files/"+filename+".jpg")
                return nil
            }
        }
        return NSData()
    }
}
