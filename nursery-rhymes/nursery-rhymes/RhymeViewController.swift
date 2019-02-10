//
//  ViewController.swift
//  nursery-rhymes
//
//  Created by Guest on 12/31/00.
//  Copyright © 2000 Team8343. All rights reserved.
//

import UIKit
import AVFoundation

class RhymeViewController: UIViewController {
    @IBOutlet weak var rhymeText: UILabel!
    var fileName = String()
    var message = String()
    var m = Model()
    var audioPlayer = AVAudioPlayer()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model.getModel()
        rhymeText.text = m.getRhymeText(rawText: m.collections["Volland"]![fileName]!)
        self.navigationItem.title = message;
        
        if (fileName.contains("MGV")) {
            print (fileName)
            let address = fileName + "HE1"
            print (address)
            let homeExperience = URL(fileURLWithPath: Bundle.main.path(forResource: address, ofType: "mp3", inDirectory: "transcripts")!)
            print(homeExperience)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: homeExperience)
                audioPlayer.prepareToPlay()
            } catch {
                print("aww beans, the thing didn't get the mp3 correctly")
            }
        }

        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func homeexperience(_ sender: UIButton) {
        print("I am playing audio?")
        audioPlayer.play()
    }
    
}

