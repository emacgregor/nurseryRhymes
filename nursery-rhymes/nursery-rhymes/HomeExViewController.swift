//
//  HomeExViewController.swift
//  nursery-rhymes
//
//  Created by Ethan MacGregor on 2/12/19.
//  Copyright © 2019 Team8343. All rights reserved.
//

import UIKit
import AVFoundation

class HomeExViewController: UIViewController, AVAudioPlayerDelegate {
    var id = Int()
    var m = Model()
    var homeExAudio = [AVAudioPlayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        
        homeExAudio = m.getHomeExAudio(id: id)
        addButtonsLoop()
    }
    
    //From StackOverflow user Atif Shabeer https://stackoverflow.com/questions/44409412/dynamically-add-buttons-in-swift
    func addButtonsLoop()
    {
        
        for _view in view.subviews{
            _view.removeFromSuperview()
        }
        
        var i = 0
        var buttonY = 20
        let buttonGap = 5
        
        for audio in homeExAudio {
            
            let buttonHeight=Int(Int(view.frame.height) - 40 - (homeExAudio.count * buttonGap))/homeExAudio.count
            print(buttonHeight)
            let buttonWidth=Int(view.frame.width - 40)
            
            let button = UIButton()
            button.backgroundColor = UIColor.orange
            button.setTitle("Home Experience " + String(i), for: .normal)
            button.titleLabel?.textColor = UIColor.white
            button.frame = CGRect(x: 20, y: buttonY, width:buttonWidth , height:buttonHeight)
            button.contentMode = UIViewContentMode.scaleToFill
            buttonY += buttonHeight + buttonGap
            button.tag = i
            button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
            view.addSubview(button)
            
            i+=1
            
        }
    }
    
    func buttonTapped( _ button : UIButton)
    {
        print("I am playing the audio of Home Experience " + String(button.tag))
        homeExAudio[button.tag].play()
    }
}
