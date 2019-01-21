//
//  HomeViewController.swift
//  nursery-rhymes
//
//  Created by Guest on 12/31/00.
//  Copyright © 2000 Team8343. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var m = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model.getModel()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
