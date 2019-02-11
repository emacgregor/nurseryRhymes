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
    @IBOutlet weak var rhymeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    
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
        
        self.playRhyme()
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
    
    func playRhyme() {
        self.updater = CADisplayLink(target: self, selector: #selector(RhymeViewController.trackAudio))
        self.updater.preferredFramesPerSecond = 60
        self.updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        
        self.player = m.getRhymeAudio(id: self.id)
        self.player?.prepareToPlay()
        player?.delegate = self as? AVAudioPlayerDelegate
        self.player?.play()
    }
    
    func trackAudio() {
        let normalizedTime = Float((self.player?.currentTime)! * 100.0 / (player?.duration)!)
        timeSlider.value = normalizedTime
    }
    
}
