//
//  addVoiceVC.swift
//  LiaoRenSheng
//
//  Created by XieWeiren on 16/4/3.
//  Copyright © 2016年 Wei. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

public enum SCSiriWaveformViewInputType{
    case Recorder
    case Player
}

class addVoiceVC: UIViewController,AVAudioRecorderDelegate,AVAudioPlayerDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    ///title for recorded file that adds this title to the name of the file, (record_title_NSDate().m4a) - default is (record_NSDate().m4a)
    var soundFileTitle:String?

    
    ///recorder limit time - default is 30 secend (00:30).
    var recorderLimitTime:Double?
    
    //bool indentifing if its recording
    private var isRecording = false
    
    //the record audio file path
    private var soundFileURL:NSURL!
    
    //wave type if its record or player
    private var waveViewInputType:SCSiriWaveformViewInputType!
    
    //bool indentifing if its playing
    private var isPlaying = false
    
    //recorder instansce
    private var recorder:AVAudioRecorder!
    
    //the looper for progressCicle
    private var meterTimer:NSTimer!
    
    //the file name wich will be passed to parent viewcontroller
    private var fileName:String!
    
    //player instansce
    private var player:AVAudioPlayer!
    
    private func runMeterTimer(){
        
        meterTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolBarSetUp()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func toolBarSetUp(){
        
        self.recordButton.addTarget(self, action: "recordAudioOnClick", forControlEvents: UIControlEvents.TouchDown)
        self.recordButton.addTarget(self, action: "recordAudioOnClickRealease", forControlEvents: UIControlEvents.TouchUpInside)
        self.recordButton.addTarget(self, action: "recordAudioOnClickRealease", forControlEvents: UIControlEvents.TouchDragOutside)
        self.recordButton.addTarget(self, action: "recordAudioOnClickRealease", forControlEvents: UIControlEvents.TouchDragExit)
        
        playButton.addTarget(self, action: "playRecord", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func recordAudioOnClick(){
        print("Pressed")
        if !isRecording{
            isRecording = true
            playButton.enabled = false
            if soundFileURL != nil{
                do{
                    try NSFileManager.defaultManager().removeItemAtPath(soundFileURL.path!)
                }catch let error as NSError{
                    print(error)
                }
            }

            waveViewInputType = SCSiriWaveformViewInputType.Recorder
            setUpRecorder()
            
            do{
                try AVAudioSession.sharedInstance().setActive(true)
                recorder.record()
//                runMeterTimer()
            }catch let error as NSError{
                print(error)
            }
        }
    }
    
    func recordAudioOnClickRealease(){
        //------------------------------------------------------------------------//
        print("play")
        if isRecording{
            isRecording = false
            recorder.stop()
            
            playButton.enabled = true
            waveViewInputType = nil
            setUpPlayer()
        }
    }
    
    func playRecord(){
        //------------------------------------------------------------------------//
        if !isPlaying && player != nil{
            isPlaying = true
            
            waveViewInputType = SCSiriWaveformViewInputType.Player
            
            player.play()
        }
    }
    
    private func setUpPlayer(){
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            player = try AVAudioPlayer(contentsOfURL: recorder.url)
            player.delegate = self
            player.meteringEnabled = true
            player.prepareToPlay()
        }catch let error as NSError{
            print(error)
        }
    }

    
    private func getRecorderFileURLPath(){
        
        let format = NSDateFormatter()
        format.dateFormat = "YYYY.MM.dd-hh.mm.ss"
        
        if let fileTitle = soundFileTitle{
            let currentFileName = "record_\(fileTitle)_\(format.stringFromDate(NSDate())).m4a"
            fileName = currentFileName
            let documentDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            soundFileURL = documentDirectory.URLByAppendingPathComponent(currentFileName)
            
        }else{
            
            let currentFileName = "record_\(format.stringFromDate(NSDate())).m4a"
            let documentDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            soundFileURL = documentDirectory.URLByAppendingPathComponent(currentFileName)
            fileName = currentFileName
        }
    }
    
    private func setUpRecorder(){
        
        getRecorderFileURLPath()
        
        print(soundFileURL)
        let recorderSettings:[String:AnyObject] = [AVFormatIDKey : NSNumber(unsignedInt: kAudioFormatMPEG4AAC), AVSampleRateKey : 44100.0 as NSNumber, AVNumberOfChannelsKey : 2 as NSNumber, AVEncoderAudioQualityKey : AVAudioQuality.High.rawValue as NSNumber,AVEncoderBitRateKey : 320000 as NSNumber]
        
        do {
            recorder = try AVAudioRecorder(URL: soundFileURL, settings: recorderSettings)
            recorderLimitTime != nil ? recorder.recordForDuration(recorderLimitTime!) : recorder.recordForDuration(30.0)
            recorder.delegate = self
            recorder.meteringEnabled = true
            recorder.prepareToRecord()
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            
        }catch let error as NSError{
            print(error)
        }
    }


    



}
