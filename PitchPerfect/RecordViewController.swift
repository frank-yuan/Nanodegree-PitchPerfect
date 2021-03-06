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
    @IBOutlet weak var recordLabel: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    
    let kPlayViewSegueName = "showPlayView"
    
    // MARK: UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureUI(false)
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
        if (flag)
        {
            self.performSegueWithIdentifier(kPlayViewSegueName, sender: recorder.url)
        }
        else
        {
            let alert = UIAlertController(title: NSLocalizedString("AlertTitle", comment: ""), message:NSLocalizedString("RecordAlert", comment: ""), preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OKButton", comment: ""), style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    // MARK: Actions
    @IBAction func onRecord(sender: AnyObject) {

        configureUI(true)
        
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
        configureUI(false)
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    // MARK: Helpers
    func configureUI(recording:Bool)
    {
        stopBtn.enabled = recording
        recordBtn.enabled = !recording

        recordLabel.text = NSLocalizedString(recording ? "Recording" : "TapToRecord", comment: "")

    }
    
    
}

