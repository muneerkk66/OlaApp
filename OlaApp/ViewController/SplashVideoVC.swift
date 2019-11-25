//
//  SpalshVideoVC.swift
//  OlaApp
//
//  Created by Muneer KK on 24/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
private typealias VideoPlayerMethod = SplashVideoVC
class SplashVideoVC: UIViewController {
var splashVM = SplashVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- Register Video Player Notification
        registerForNotification()
        
        //MARK:- Method to Play Video
        playSplashVideo()

        // Do any additional setup after loading the view.
    }
    //MARK:- Play splash video
    fileprivate func playSplashVideo() {
        splashVM.startPlayer(control: self)
    }
    //MARK:- Handle video player in different app state
       fileprivate func registerForNotification() {
           NotificationCenter.default.addObserver(self, selector: #selector(SplashVideoVC.applicationDidEnterBackgroundNotification(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(SplashVideoVC.applicationDidBecomeActiveNotification(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(SplashVideoVC.applicationDidEnterInActiveStateNotification(_:)), name: UIApplication.willResignActiveNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(SplashVideoVC.playerDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
       }
    //MARK: - deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }



}
//MARK: - PLAYER NOTIFICATION HANDLING
extension VideoPlayerMethod {
    
    
    //MARK:- Show the Main Viewcontroller(TaxiListVC) when player finish the video
    @objc func playerDidFinishPlaying(_ note: Notification) {
        
        let onboardingStoryboard : UIStoryboard = UIStoryboard(name:StoryboardName.main.rawValue, bundle: Bundle.main)
        let taxiListVC  = onboardingStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.taxiListVCID.rawValue) as! TaxiListVC
        taxiListVC.modalTransitionStyle = .crossDissolve
        self.present(taxiListVC, animated: true, completion: nil)
    }
    
    //MARK:- Save Player's current time when app goes to background
    @objc func applicationDidEnterBackgroundNotification(_ notification:Notification) {
        splashVM.pausePlayer()
    }
    
    //MARK:- Save Player's current time on app going to inactive state
    @objc func applicationDidEnterInActiveStateNotification(_ notification:Notification) {
        splashVM.pausePlayer()
    }
    
    //MARK:- Called when application becomes active
    @objc func applicationDidBecomeActiveNotification(_ notification:Notification) {
        splashVM.restartPlayer()
    }

}
