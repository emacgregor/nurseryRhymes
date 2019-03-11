//
//  ViewController.swift
//  nursery-rhymes
//
//  Created by Guest on 12/31/00.
//  Copyright © 2000 Team8343. All rights reserved.
//

import UIKit
import AVFoundation

class RhymeViewController: UIViewController, AVAudioPlayerDelegate {
    var collectionName = String()
    @IBOutlet weak var rhymeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBOutlet var playButton: UIBarButtonItem!
    @IBAction func rewindClicked(_ sender: Any) {
    }
    @IBAction func fastforwardClicked(_ sender: Any) {
    }
    @IBAction func playClicked(_ sender: Any) {
        if (m.audioContainer.isPlaying()) {
            m.audioContainer.pause()
            playButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.play, target: self, action: #selector(RhymeViewController.playClicked))
        } else {
            m.audioContainer.play()
            playButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.pause, target: self, action: #selector(RhymeViewController.playClicked))
        }
    }
    
    @IBAction func popToRhymeList(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var homeExperienceBar: UIToolbar!
    
    var id = Int()
    var message = String()
    var m = Model()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model.getModel()
        collectionName = m.getRhymeCollection(id: self.id)
        
        if (collectionName == "Volland") {
             m.highlightingContainer.loadRhyme(id: self.id, rhymeViewController: self)
        } else {
            self.buildHomeExBar()
            self.rhymeLabel.text = m.getRhymeText(id: self.id)
            m.audioContainer.loadFile(filename: m.getRhymeFileName(id: self.id))
        }


        
        self.navigationItem.title = message;
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        self.homeExperienceBar.setBackgroundImage(UIImage(),
                                        forToolbarPosition: .any,
                                        barMetrics: .default)
        self.homeExperienceBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        self.timeSlider.minimumValue = 0
        self.timeSlider.maximumValue = 100
        
    
        m.audioContainer.play()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    override func viewWillDisappear(_ animated: Bool) {
        m.audioContainer.stop()
        m.highlightingContainer.reset()
    }
    
    func buildHomeExBar() {
        var homeExBarItems = [UIBarButtonItem]()
        let homeExCount = m.getHomeExCount(id: self.id)
        homeExBarItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                   target: nil,
                                                   action: nil))
        if (homeExCount > 0) {
            for i in 0..<homeExCount {
                let heButton = UIBarButtonItem()
                heButton.title = ""
                heButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "FontAwesome", size: UIFont.buttonFontSize)!], for: UIControlState.normal)
                heButton.target = self
                heButton.action = #selector(RhymeViewController.playHomeExperience)
                heButton.tag = i
                homeExBarItems.append(heButton)
            }
        }
        homeExBarItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                   target: nil,
                                                   action: nil))
        self.homeExperienceBar.items = homeExBarItems
    }
    
    func playHomeExperience(sender: UIBarButtonItem) {
        m.audioContainer.stop()
        m.highlightingContainer.reset()
        
        let homeExId = sender.tag + 1
        m.audioContainer.loadFile(filename: m.getHomeExFilename(rhymeId: id, homeExId: homeExId))
        m.audioContainer.play()
    }
    
    @IBAction func quizClick(_ sender: Any) {
        performSegue(withIdentifier: "quiz", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("In")
        if let vc = segue.destination as? QuizViewController {
            print("VC")
            
            vc.id = self.id
            vc.message = self.message
        }
    }

    
}
