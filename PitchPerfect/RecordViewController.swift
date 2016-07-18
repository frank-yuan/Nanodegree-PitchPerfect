//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Xuan Yuan (Frank) on 7/18/16.
//  Copyright © 2016 frank-yuan. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    // MARK: Properties
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    let kPlayViewSegueName = "showPlayView"
    
    // MARK: UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopBtn.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == kPlayViewSegueName)
        {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            playSoundsVC.recordedAudioURL = sender as! NSURL
        }
    }
    
    // MARK: AVAudioRecorderDelegate overrides

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print(recorder.url)
        self.performSegueWithIdentifier(kPlayViewSegueName, sender: recorder.url)
    }
    
    
    // MARK: Actions
    @IBAction func onRecord(sender: AnyObject) {
        stopBtn.enabled = true
        recordBtn.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func onStop(sender: AnyObject) {
        stopBtn.enabled = false
        recordBtn.enabled = true
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    
}

