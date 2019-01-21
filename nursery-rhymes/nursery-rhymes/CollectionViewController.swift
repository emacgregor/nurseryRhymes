//
//  CollectionViewController.swift
//  nursery-rhymes
//
//  Created by Guest on 12/31/00.
//  Copyright © 2000 Team8343. All rights reserved.
//


import UIKit

class CollectionViewController : UIViewController {
   
    @IBOutlet weak var back: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
//        self.navigationController?.navigationBar.barTintColor = UIColor(red:1, green:1, blue:1, alpha:1.0)
        
        self.back.tintColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange] // swift 4.2
    }
    
}
