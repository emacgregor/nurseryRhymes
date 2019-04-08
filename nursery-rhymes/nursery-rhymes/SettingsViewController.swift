//
//  SettingsViewController.swift
//  nursery-rhymes
//
//  Created by Zachary Cheshire on 1/20/19.
//  Copyright © 2019 Team8343. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController {
    var m = Model()
    @IBOutlet weak var coinAmount: UILabel!
    @IBOutlet weak var fontSize: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        fontSize.text = "\(m.coreData.getFont() ?? 17)"
        coinAmount.font = coinAmount.font.withSize(CGFloat(m.coreData.getFont()!))
        coinAmount.text = "\(m.coreData.getScore() ?? 0)"
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        
    }
    @IBAction func saveButton(_ sender: Any) {
        m.coreData.saveFont(score: Int(self.fontSize.text!) ?? 17)
      
    }
}
