//
//  ViewController.swift
//  nursery-rhymes
//
//  Created by Guest on 12/31/00.
//  Copyright © 2000 Team8343. All rights reserved.
//

import UIKit

class RhymeViewController: UIViewController {

    var m = Model()
    @IBOutlet weak var rhymeText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model.getModel()
        
        rhymeText.text = m.getRhymeText(rawText: m.collections["Volland"]!["V_21_WillieBoy"]!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

