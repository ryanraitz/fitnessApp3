//
//  DetailViewController.swift
//  fitnessApp
//
//  Created by Ryan R/Users/ryanraitz/Downloads/fitnessApp/fitnessApp/TitleCell.swiftaitz on 10/15/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class DetailViewController : UIViewController {

//Properties


    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBAction func watchDemoAction(_ sender: Any) {
        
        guard let path = Bundle.main.path(forResource: selectedLocation?.videoURL,
            ofType: "mp4") else { return }
        let videoLink = URL(fileURLWithPath: path)
        let player = AVPlayer(url: videoLink)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
        
    }
    
    @IBOutlet weak var watchDemo: UIButton!

    
    var selectedLocation : LocationModel?
    

    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        //scrollView.backgroundColor = .clear
        //self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemTeal]
        //
        //Dynamically Resize text view based on content
        //
        let fixedWidth = descriptionLabel.frame.size.width
        let newSize: CGSize = descriptionLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        var newFrame = descriptionLabel.frame
        newFrame.size = CGSize(width: CGFloat(fmaxf(Float(newSize.width), Float(fixedWidth))), height: newSize.height)
        descriptionLabel.frame = newFrame
        //
        //Add shadows to labels
        //
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 10, height: 10)
        titleLabel.layer.shadowRadius = 10
        titleLabel.layer.shadowOpacity = 1.0
        
        overviewLabel.layer.shadowColor = UIColor.black.cgColor
        overviewLabel.layer.shadowOffset = CGSize(width: 10, height: 10)
        overviewLabel.layer.shadowRadius = 10
        overviewLabel.layer.shadowOpacity = 1.0
        
        //watchDemoLabel.layer.shadowColor = UIColor.black.cgColor
        //watchDemoLabel.layer.shadowOffset = CGSize(width: 10, height: 10)
        //watchDemoLabel.layer.shadowRadius = 10
        //watchDemoLabel.layer.shadowOpacity = 1.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Initialize cell text labels to desired info
        titleLabel.text = selectedLocation?.exerciseName
        descriptionLabel.text = selectedLocation?.exerciseDescription
    }
    
 /*   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
            let touch = touches.first!
            //Make sure video only plays if user clicks in the video box
            if touch.view == watchDemo
            {
                guard let path = Bundle.main.path(forResource: selectedLocation?.videoURL,
                    ofType: "mp4") else { return }
                let videoLink = URL(fileURLWithPath: path)
                let player = AVPlayer(url: videoLink)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                
                self.present(playerViewController, animated: true) {
                    playerViewController.player?.play()
                }
            }
    }
 */
    
}
