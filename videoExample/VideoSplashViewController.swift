//
//  VideoSplashViewController.swift
//  videoExample
//
//  Created by Ahmed Elzohry on 5/27/19.
//  Copyright © 2019 Ahmed Elzohry. All rights reserved.
//

import UIKit
import AVFoundation


class VideoSplashViewController: UIViewController {
    
    @IBOutlet weak var videoContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        playVideos()
    }
    
    var playerLayer: AVPlayerLayer!
    
    private func playVideos() {
        guard let videoPath = Bundle.main.path(forResource: "intro", ofType:"mp4") else {
            fatalError("can't find intro.mp4 file")
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: videoPath))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.zPosition = -1
        self.videoContainerView.layer.addSublayer(playerLayer)
        
        player.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            self.showMainController()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        playerLayer.frame = videoContainerView.frame
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func showMainController() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main")
        window.rootViewController = mainController
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }

}
