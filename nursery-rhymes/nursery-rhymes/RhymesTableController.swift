//
//  RhymesTableController.swift
//  nursery-rhymes
//
//  Created by Zachary Cheshire on 1/20/19.
//  Copyright © 2019 Team8343. All rights reserved.
//

import UIKit
struct cellData {
    let image: UIImage?
    let message: String?
}
class RhymesTableController : UITableViewController {
    var data = [cellData]()
    override func viewDidLoad() {
        let img = UIImage(named: "pandaprofile")
        data = [cellData.init(image: img, message: "hello")]
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
}
