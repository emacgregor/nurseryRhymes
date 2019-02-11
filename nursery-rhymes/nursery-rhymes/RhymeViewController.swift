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
    @IBOutlet weak var rhymeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBAction func rewindClicked(_ sender: Any) {
    }
    @IBAction func fastforwardClicked(_ sender: Any) {
    }
    @IBAction func playClicked(_ sender: Any) {
        if (self.player?.isPlaying)! {
            self.pauseRhyme()
            playButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.play, target: self, action: #selector(RhymeViewController.playClicked))
        } else {
            self.playRhyme()
            playButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.pause, target: self, action: #selector(RhymeViewController.playClicked))
        }
    }
    
    var id = Int()
    var message = String()
    var player: AVAudioPlayer?
    var updater: CADisplayLink! = nil
    
    var m = Model()
    
    var transcript = String()
    var rhymeText = String()
    var remainingText = String()
    var wordIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model.getModel()
        self.transcript = m.getRhymeTranscript(id: self.id)
        self.rhymeText = m.getRhymeText(id: self.id)
        self.remainingText = self.rhymeText
        
        self.navigationItem.title = message;
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        self.player = AVAudioPlayer()
        self.timeSlider.minimumValue = 0
        self.timeSlider.maximumValue = 100
        
        let attrText = self.buildAttributedText(wordIndex: self.wordIndex)
        rhymeLabel.attributedText = (attrText.copy() as! NSAttributedString)
        
        self.preparePlayer()
        self.playRhyme()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.player?.stop()
        self.updater.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buildAttributedText(wordIndex: Int) -> NSMutableAttributedString {
        let attrText = NSMutableAttributedString(string: self.rhymeText)
        let wordRange = getCurrentWordRange(wordIndex: wordIndex)
        print("wordRange: \(wordRange)")
        attrText.addAttribute(NSBackgroundColorAttributeName,
                          value: UIColor.yellow,
                          range: wordRange)
        return attrText
    }
    
    func getCurrentWordRange(wordIndex: Int) -> NSRange {
        let lines = self.transcript.characters.split(separator: "\n")
        let words = lines[wordIndex].split(separator: " ")
        
        var word = String(words[1]).lowercased()
        let end = word.index(word.endIndex, offsetBy: -1)
        word = word.substring(to: end)
        
        // Search for word in remainingText
        return (self.remainingText.lowercased() as NSString).range(of: word)
    }
    
    func preparePlayer() {
        self.updater = CADisplayLink(target: self, selector: #selector(RhymeViewController.trackAudio))
        self.updater.preferredFramesPerSecond = 60
        self.updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        
        self.player = m.getRhymeAudio(id: self.id)
        self.player?.delegate = self as AVAudioPlayerDelegate
    }
    
    func playRhyme() {
        self.player?.prepareToPlay()
        self.player?.play()
    }
    
    func pauseRhyme() {
        self.player?.pause()
        
    }
    
    func trackAudio() {
        let normalizedTime = Float((self.player?.currentTime)! * 100.0 / (player?.duration)!)
        timeSlider.value = normalizedTime
    }
    
}
