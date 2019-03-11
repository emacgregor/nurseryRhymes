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
    var collectionName: String!
    
    @IBOutlet weak var collectionNameLabel: UINavigationItem!
    
    var m = Model.getModel()
    
    var data = [cellData]()
    
    override func viewDidLoad() {
        var formattedName = collectionName
        if (formattedName == "MGV") {
            formattedName = "Mother Goose Visit"
        } else if (formattedName == "FGV") {
            formattedName = "Father Goose Visit"
        }
        collectionNameLabel.title = formattedName
        let collectionRhymes = m.getRhymesForCollection(collectionName: self.collectionName)
        for id in Array(collectionRhymes.keys) {
            let rhymeid = Int((collectionRhymes[id]?["id"]!)!)!
            
            //Make sure rhyme files exist before we display it
            if (m.getRhymeTranscript(id: rhymeid) != "") {
                data.append(cellData(
                    image: m.getRhymeImage(id: rhymeid),
                    message: m.getRhymeName(id: rhymeid),
                    id: rhymeid
                ))
            }
        }
        
        data.sort { (a, b) -> Bool in
            let comparison = a.message?.localizedCaseInsensitiveCompare(b.message ?? "")
            return (comparison == ComparisonResult.orderedAscending)
        }
        
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
    }
    
    @IBAction func popToCollectionList(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell
        
        cell.homeExpExists = (m.getHomeExCount(id: data[indexPath.row].id!) > 0)
           
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
