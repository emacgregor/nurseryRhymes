//
//  HighlightingContainer.swift
//  nursery-rhymes
//
//  Created by Zachary Cheshire on 3/10/19.
//  Copyright © 2019 Team8343. All rights reserved.
//

//import Foundation
import AVFoundation
import UIKit

class HighlightingContainer: NSObject, AVAudioPlayerDelegate {
    var transcript = String()
    var transcriptTimes = [(Float, Float)]()
    var rhymeText = String()
    var remainingText = String()
    var wordIndex = 0
    var id = 0
    var rhymeViewController: RhymeViewController?
    var updater: CADisplayLink! = nil
    
    override init() {
        super.init()
        self.reset()
    }
    
    func loadRhyme(id: Int, rhymeViewController: RhymeViewController) {
        self.reset()
        let m = Model.getModel()
        m.audioContainer.loadFile(filename: m.getRhymeFileName(id: id))
        
        self.id = id
        self.transcript = m.getRhymeTranscript(id: self.id)
        self.rhymeText = m.getRhymeText(id: self.id)
        self.remainingText = self.rhymeText
        self.parseTranscript()
        self.rhymeViewController = rhymeViewController
        m.audioContainer.setDelegate(delegate: self)
        self.updater = CADisplayLink(target: self , selector: #selector(self.trackAudio))
        self.updater.preferredFramesPerSecond = 60
        self.updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        
        //Display unhighlighted text on load
        self.rhymeViewController!.rhymeLabel.attributedText = (NSMutableAttributedString(string: self.rhymeText).copy() as! NSAttributedString)
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
            self.rhymeViewController!.rhymeLabel.attributedText = (attrText.copy() as! NSAttributedString)
            
            var newRemaining = NSString(string: remainingText)
            //get rid of this range so that we don't re-highlight the first location of a word
            newRemaining = newRemaining.substring(with:
                NSMakeRange(wordRange.length + wordRange.location,
                            newRemaining.length - (wordRange.length + wordRange.location))) as NSString
            
            //make sure to trim whitespace
            newRemaining = newRemaining.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) as NSString
            self.remainingText = newRemaining as String
            //self.remainingText = (newRemaining as String).trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    func trackAudio() {
        let m = Model.getModel()
        
        if (transcriptTimes[wordIndex].1 < Float((m.audioContainer.getCurrentTime())!) ) {
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
    
    func getCurrentWordRange(wordIndex: Int) -> NSRange {
        let lines = self.transcript.characters.split(separator: "\n")
        if wordIndex < lines.count {
            let words = lines[wordIndex].split(separator: " ")
            
            var word = String(words[1]).lowercased()
            let end = word.index(word.endIndex, offsetBy: -1)
            word = word.substring(to: end)
            
            // Search for word in remainingText
            let range = (self.remainingText.lowercased() as NSString).range(of: word)
            return range
        } else {
            return NSMakeRange(0, 0)
        }
    }
    
    func reset() {
        self.id = Int()
        self.transcript = String()
        self.rhymeText = String()
        self.remainingText = String()
        self.remainingText = String()
        self.wordIndex = Int()
        self.updater = nil
    }
    
}
