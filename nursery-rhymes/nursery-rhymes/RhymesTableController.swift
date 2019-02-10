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
    let id: Int?
}
class RhymesTableController : UITableViewController {
    var data = [cellData]()
    
    var m = Model.getModel()
    
    override func viewDidLoad() {
        for (id, _) in m.rhymes.enumerated() {
            data.append(cellData(
                image: m.getRhymeImage(id: id),
                message: m.getRhymeName(id: id),
                id: id
            ))
        }
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "cellSegue", sender: self)
        print(indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("In")
        if let vc = segue.destination as? RhymeViewController {
            print("VC")
            print(tableView.indexPathForSelectedRow?.row as Any)
            let cellIndex = tableView.indexPathForSelectedRow?.row
            print(cellIndex!)
            vc.id = data[cellIndex!].id!
            vc.message = data[cellIndex!].message!
        }
    }
    
}
