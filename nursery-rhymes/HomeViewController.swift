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
    
    @IBOutlet weak var logout: UIBarButtonItem!
    
    @IBOutlet weak var rhymesButton: RoundButton!

    @IBOutlet weak var settingsButton: RoundButton!
    
    
    @IBOutlet weak var analyticsButton: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        
        self.logout.tintColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        
        self.rhymesButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: [])
       // self.rhymesButton.borderColor();
        self.settingsButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: [])

        self.analyticsButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: [])

        
        

        m = Model.getModel()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
