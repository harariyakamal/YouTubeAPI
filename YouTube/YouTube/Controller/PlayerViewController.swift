//
//  PlayerViewController.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/17/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PlayerViewController: UIViewController {
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer: AVPlayer?
    
    /// Video id.
    var videoIdentifier: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.random
        
        let ytplayerview = YTPlayerView(frame: view.frame)
        self.view.addSubview(ytplayerview)
        
        if let _videoId = videoIdentifier {
            ytplayerview.load(withVideoId: _videoId)
        }
    }
}
