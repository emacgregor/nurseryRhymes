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
            //self.pauseRhyme()
            playButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.play, target: self, action: #selector(RhymeViewController.playClicked))
        } else {
            //self.playRhyme()
            playButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.pause, target: self, action: #selector(RhymeViewController.playClicked))
        }
    }
    
    @IBAction func popToRhymeList(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var homeExperienceBar: UIToolbar!
    
    var id = Int()
    var message = String()
    var player: AVAudioPlayer?
    var updater: CADisplayLink! = nil
    
    var m = Model()
    
    var transcript = String()
    var transcriptTimes = [(Float, Float)]()
    var rhymeText = String()
    var remainingText = String()
    var wordIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model.getModel()
        self.transcript = m.getRhymeTranscript(id: self.id)
        self.rhymeText = m.getRhymeText(id: self.id)
        self.remainingText = self.rhymeText
        self.parseTranscript()
        
        self.navigationItem.title = message;
        self.view.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        //self.player = AVAudioPlayer()
        self.timeSlider.minimumValue = 0
        self.timeSlider.maximumValue = 100
        
        self.buildAttributedText(wordIndex: self.wordIndex)

        self.buildHomeExBar()
        //Make sure you do this after building home experience bar,
        //or wrong audio will play
        //self.preparePlayer()  <-- move into playRhyme now that we're reusing player for HE's
        //self.playRhyme()
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
    
    func buildHomeExBar() {
        var homeExBarItems = [UIBarButtonItem]()
        var homeExCount = 0
        var index = 1
        
        while (index != 0) {
            //not actually using audio, just checking if it's there
            let homeExFilename = m.getHomeExFilename(rhymeId: id, homeExId: index)
            if (homeExFilename == "") {
                //End loop
                homeExCount = index - 1
                index = 0
            }
        }
        
        homeExBarItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                   target: nil,
                                                   action: nil))
        if (homeExCount > 0) {
            for i in 0..<homeExCount {
                let button = UIBarButtonItem(barButtonSystemItem: .play,
                                                       target: self,
                                                       action: #selector(RhymeViewController.playHomeExperience))
                button.tag = i
                homeExBarItems.append(button)
            }
        }
        homeExBarItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                   target: nil,
                                                   action: nil))
        self.homeExperienceBar.items = homeExBarItems
    }
    
    func playHomeExperience(sender: UIBarButtonItem) {
        self.player?.stop()
        self.updater.invalidate()
        
        let homeExId = sender.tag + 1
        //self.player = m.getHomeExAudio(rhymeId: id, homeExId: homeExId)
        self.player?.delegate = self as AVAudioPlayerDelegate
        self.player?.prepareToPlay()
        self.player?.play()
    }
    
    func buildAttributedText(wordIndex: Int) {
        let difference = NSString(string: rhymeText).length - NSString(string: remainingText).length
        
        let attrText = NSMutableAttributedString(string: self.rhymeText)
        let wordRange = getCurrentWordRange(wordIndex: wordIndex)
        if (wordRange.length > 0) {
            let correctedRange = NSMakeRange(wordRange.location + difference - 1,
                                             wordRange.length)
            attrText.addAttribute(NSBackgroundColorAttributeName,
                              value: UIColor.yellow,
                              range: correctedRange)
            self.rhymeLabel.attributedText = (attrText.copy() as! NSAttributedString)
            
            var newRemaining = NSString(string: remainingText)
            //get rid of this range so that we don't re-highlight the first location of a word
            newRemaining = newRemaining.substring(with:
                NSMakeRange(wordRange.length, newRemaining.length - wordRange.length)) as NSString
            
            //make sure to trim whitespace
            newRemaining = newRemaining.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) as NSString
            self.remainingText = newRemaining as String
            //self.remainingText = (newRemaining as String).trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    func getCurrentWordRange(wordIndex: Int) -> NSRange {
        let lines = self.transcript.characters.split(separator: "\n")
        let words = lines[wordIndex].split(separator: " ")
        
        var word = String(words[1]).lowercased()
        let end = word.index(word.endIndex, offsetBy: -1)
        word = word.substring(to: end)
        
        // Search for word in remainingText
        let range = (self.remainingText.lowercased() as NSString).range(of: word)
        return range
    }
    
    /*func preparePlayer() {
        self.updater = CADisplayLink(target: self, selector: #selector(RhymeViewController.trackAudio))
        self.updater.preferredFramesPerSecond = 60
        self.updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        
        self.player = m.getRhymeAudio(id: self.id)
        self.player?.delegate = self as AVAudioPlayerDelegate
    }*/
    
    /*func playRhyme() {
        self.preparePlayer()
        self.player?.prepareToPlay()
        self.player?.play()
    }*/
    
    func pauseRhyme() {
        self.player?.pause()
    }
    
    func parseTranscript() {
        let lines = self.transcript.characters.split(separator: "\n")
        for (_, line) in lines.enumerated() {
            let words = line.split(separator: " ")
            
            if (words.count >= 6) {
                var word = String(words[3])
                //Remove comma
                let end = word.index(word.endIndex, offsetBy: -1)
                word = word.substring(to: end)
                let startTime = Float(word)
                let endTime = Float(String(words[5]))
                transcriptTimes.append((startTime!,endTime!))
            }
        }
    }
    
    func trackAudio() {
        let normalizedTime = Float((self.player?.currentTime)! * 100.0 / (player?.duration)!)
        timeSlider.value = normalizedTime
        
        if (transcriptTimes[wordIndex].1 < Float((self.player?.currentTime)!) ) {
            if (wordIndex < (transcriptTimes.count - 1)) {
                wordIndex += 1
                //rebuild the label only when word change is detected
                self.buildAttributedText(wordIndex: self.wordIndex)
            }
        }
    }
    
    // From AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //reset highlighting when audio finishes
        self.wordIndex = 0
        self.remainingText = self.rhymeText
        //self.preparePlayer()
        self.buildAttributedText(wordIndex: self.wordIndex)
    }
}
