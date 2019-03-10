//
//  AudioContainer.swift
//  nursery-rhymes
//
//  Created by Jack Bonaguro on 3/2/19.
//  Copyright © 2019 Team8343. All rights reserved.
//

import Foundation
import AVFoundation

class AudioContainer {
    var player: AVAudioPlayer?
    var loadedFilename: String?
    
    init() {
        self.reset()
    }
    
    func loadFile(filename: String) -> Bool {
        self.reset()
        
        if let url = Bundle.main.url(forResource: filename, withExtension: "mp3", subdirectory: "rhyme_files")
        {
            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                self.loadedFilename = filename;
                return true
            } catch let error {
                print(error.localizedDescription)
                return false
            }
        } else {
            print("File not found: rhyme_files/"+filename+".jpg")
            return false
        }
    }
    
    func play() {
        self.player?.prepareToPlay()
        self.player?.play()
    }
    
    func pause() {
        self.player?.pause()
    }
    
    func stop() {
        self.player?.stop()
    }
    
    func reset() {
        self.player = AVAudioPlayer();
        self.loadedFilename = nil
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getLoadedFilename() -> String? {
        return self.loadedFilename
    }
    
    func getCurrentTime() -> TimeInterval? {
        return self.player?.currentTime
    }
    
    
    // From AVAudioPlayerDelegate
    func setDelegate(viewController: AVAudioPlayerDelegate) {
        self.player?.delegate = viewController
    }
    
    func isPlaying() -> Bool {
        return (self.player?.isPlaying)!
    }
    
  
}

