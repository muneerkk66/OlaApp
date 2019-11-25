//
//  SplashVM.swift
//  OlaApp
//
//  Created by Muneer KK on 26/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
class SplashVM: BaseVM {
    var playerController =  AVPlayerViewController()
    var player:AVPlayer?
    var seekTime:CMTime?
    
    func startPlayer(control:UIViewController) {
           let audioSession = AVAudioSession.sharedInstance()
           _ = try? audioSession.setCategory(.playback, options: .defaultToSpeaker)
           _ = try? audioSession.setActive(true) //Causes audio from other sessions to be continue audio from this session plays
           let videoPath = Bundle.main.path(forResource: OlaAppConstants.videofileName, ofType: OlaAppConstants.videofiletype)
           let videoURL = URL(fileURLWithPath: videoPath!)
           player = AVPlayer(url: videoURL)
           playerController.player = player
           playerController.showsPlaybackControls = false
           playerController.view.backgroundColor = UIColor.clear
           control.view.backgroundColor = UIColor.clear
           playerController.view.frame = control.view.bounds
           playerController.videoGravity = AVLayerVideoGravity(rawValue: AVLayerVideoGravity.resizeAspect.rawValue)
           control.view.addSubview(playerController.view)
           control.addChild(playerController)
           player!.play()
       }
    func pausePlayer(){
        player?.pause()
        seekTime = player?.currentTime()
    }
    func restartPlayer(){
        if let _ = seekTime {
            player?.seek(to: seekTime!)
        }
        player?.play()
    }
}
