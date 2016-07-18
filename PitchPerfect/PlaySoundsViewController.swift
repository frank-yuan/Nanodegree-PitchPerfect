//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Xuan Yuan (Frank) on 7/18/16.
//  Copyright © 2016 frank-yuan. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlaySoundsViewController : UIViewController {
    
    // MARK:Properties
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!


    var recordedAudioURL: NSURL!
    var audioFile:AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer : NSTimer!

    enum PlayType: Int {
        case Slow = 0,
        Fast,
        Chipmunk,
        Vader,
        Echo,
        Reverb
    }
    
    // MARK: UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        configureUI(.NotPlaying)
    }
    
    // MARK: IBActions
    @IBAction func onPlay(sender: AnyObject) {
        switch (PlayType(rawValue: sender.tag)!)
        {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.Playing)
    }
    @IBAction func onStop(sender: AnyObject) {
        stopAudio()
        configureUI(.NotPlaying)
    }
}