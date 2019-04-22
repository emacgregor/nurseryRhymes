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
    var count = 0
    @IBOutlet weak var rhymeLabel: UILabel!
    @IBOutlet weak var rhymeImageView: UIImageView!
    
    @IBOutlet weak var timeSlider: UISlider!
    var updater: CADisplayLink!
    @IBOutlet weak var controlView: UIView!
    
    @IBOutlet var playButton: UIButton!
    @IBAction func playTouched(_ sender: Any) {
        //Play button is strictly for Rhyme Audio, not Home Experiences
        if (m.getRhymeFileName(id: self.id) == m.audioContainer.getLoadedFilename()) {
            if (m.audioContainer.isPlaying()) {
                m.audioContainer.pause()
                playButton.setTitle("", for: UIControlState.normal) //Play Button
            } else {
                m.audioContainer.play()
                playButton.setTitle("", for: UIControlState.normal) //Pause Button
            }
        } else {
            m.audioContainer.stop()
            m.audioContainer.loadFile(filename: m.getRhymeFileName(id: self.id))
            m.audioContainer.play()
            playButton.setTitle("", for: UIControlState.normal) //Pause Button
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
        count = m.coreData.getCurrentViews(id: String(self.id)) ?? 0
        count = count + 1
        m.coreData.saveCurrentViews(id: self.id, views: count)
        self.loadRhyme()
        
        let quiz = m.getQuiz(rhyme: self.id, level: 0)
        let hasQuiz = (quiz != [:])
        self.quizButton.isEnabled = hasQuiz
        
        if (collectionName != "Volland") {
            if (collectionName != "Jerrold") {
                self.buildHomeExBar()
            }
            self.rhymeLabel.text = m.getRhymeText(id: self.id)
            
            //Stuff that is handled by HighlightingContainer in the other case
            self.updater = CADisplayLink(target: self , selector: #selector(self.trackAudio))
            self.updater.preferredFramesPerSecond = 60
            self.updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
            m.audioContainer.setDelegate(delegate: self)
        }
        
        let rhymeImage = m.getRhymeImage(id: self.id)
        self.rhymeImageView.image = rhymeImage
        let aspectWidth = (self.rhymeImageView.frame.height / rhymeImage.size.height) * rhymeImage.size.width
        self.rhymeImageView.widthAnchor.constraint(equalToConstant: aspectWidth).isActive = true
        
        self.navigationItem.title = message;
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        self.homeExperienceBar.setBackgroundImage(UIImage(),
                                        forToolbarPosition: .any,
                                        barMetrics: .default)
        self.homeExperienceBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        timeSlider.leftAnchor.constraint(equalTo: self.playButton.rightAnchor).isActive = true
        timeSlider.rightAnchor.constraint(equalTo: self.controlView.rightAnchor).isActive = true
        
        self.timeSlider.minimumValue = 0
        self.timeSlider.maximumValue = 100
    
        m.audioContainer.play()
        playButton.setTitle("", for: UIControlState.normal) //Pause Button\
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeRight, andRotateTo: UIInterfaceOrientation.landscapeRight)

        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)

        m.audioContainer.stop()
        m.highlightingContainer.reset()
    }
    
    func loadRhyme() {
        if (collectionName == "Volland") {
            m.highlightingContainer.loadRhyme(id: self.id, rhymeViewController: self)
        } else {
            m.audioContainer.loadFile(filename: m.getRhymeFileName(id: self.id))
        }
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
                heButton.tag = i + 1
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
        
        let homeExId = sender.tag
        m.audioContainer.loadFile(filename: m.getHomeExFilename(rhymeId: id, homeExId: homeExId))
        m.audioContainer.play()
        playButton.setTitle("", for: UIControlState.normal) //Play Button
    }
    
    @IBOutlet weak var quizButton: UIBarButtonItem!
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

    func trackAudio() {
        let normalizedTime = Float((m.audioContainer.player?.currentTime)! * 100.0
            / (m.audioContainer.player?.duration)!)
        timeSlider.value = normalizedTime
    }
    
    // From AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //Clean up after rhyme is finished
        //playButton.setTitle("", for: UIControlState.normal) //Play Button
        playButton.setTitle("", for: UIControlState.normal) //Pause Button
    }
}
