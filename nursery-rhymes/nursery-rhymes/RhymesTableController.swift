//
//  RhymesTableController.swift
//  nursery-rhymes
//
//  Created by Zachary Cheshire on 1/20/19.
//  Copyright © 2019 Team8343. All rights reserved.
//
import Foundation
import UIKit
struct cellData {
    let image: UIImage?
    let message: String?
}
class RhymesTableController : UITableViewController {
    var data = [cellData]()
    
    var m = Model.getModel()
    
    override func viewDidLoad() {
        let name = "pandaprofile.png"
        let img = UIImage(named: name)
        data = []
        //[cellData(image: img, message: "hello")]
        for (fileName, _) in m.collections["Volland"]! {
            data.append(cellData(image: img, message: m.getRhymeName(fileName: fileName)))
        }
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell
        cell.mainImage = data[indexPath.row].image
        cell.message = data[indexPath.row].message
        cell.layoutSubviews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  data.count
    }
    
}
