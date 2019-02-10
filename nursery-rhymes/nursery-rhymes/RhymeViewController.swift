//
//  ViewController.swift
//  nursery-rhymes
//
//  Created by Guest on 12/31/00.
//  Copyright © 2000 Team8343. All rights reserved.
//

import UIKit

class RhymeViewController: UIViewController {
    @IBOutlet weak var rhymeText: UILabel!
    var id = Int()
    var message = String()
    var m = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model.getModel()
        // rhymeText.text = m.getRhymeText(id: id)
        self.navigationItem.title = message;
        
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        
        let textArr = m.getRhymeText(id: id).characters.split(separator: "\n")
        let attrText = NSMutableAttributedString()
        
        for (index, text) in textArr.enumerated() {
            let text = String(text) as NSString
            let attr = NSMutableAttributedString(string: text as String)
            if (index == 0) {
                attr.addAttribute(NSBackgroundColorAttributeName,
                                  value: UIColor.yellow,
                                  range: NSMakeRange(0, text.length))
            }
            attrText.append(attr)
        }
        
        rhymeText.attributedText = (attrText.copy() as! NSAttributedString)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
