//
//  DetailsViewController.swift
//  fitnessApp
//
//  Created by Ryan Raitz on 11/9/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import FirebaseStorage

//View controller for the overview/mind muscle connection view
class DetailsViewController : UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myTextLabel: UILabel!
    
    @IBOutlet weak var mindMuscleConnectionTextLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var watchDemoLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var selectedLocation : LocationModel?
    
    var storage = Storage.storage()
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer:AVPlayer? = nil
    
    //Top right bar button function to watch the video demo of the given workout
    @IBAction func watchDemo(_ sender: Any)
    {
        
        self.present(self.avPlayerViewController, animated: true)
        {
            self.avPlayerViewController.player?.play()
        }
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Navigation bar styling
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        //Adding shadow to title label
        myLabel.layer.shadowColor = UIColor.black.cgColor
        myLabel.layer.shadowOffset = CGSize(width: 10, height: 10)
        myLabel.layer.shadowRadius = 10
        myLabel.layer.shadowOpacity = 1.0
        
        //Concatenate proper url for video playback using stored videoURL
        let string1 = "gs://rickfit-4976a.appspot.com/videos/"
        guard let string2 = selectedLocation?.videoURL else { return }
        let string3 = ".mp4"
        let urlString = string1 + string2 + string3
        
        //print(urlString)
        
        //Create cloud storage reference
        let gsReference = self.storage.reference(forURL: urlString)
        
        //Download url from cloud storage reference
        gsReference.downloadURL { url, error in
            if error != nil
             {
               print("Could not load video from URL")
             }
             else
             {
               self.avPlayer = AVPlayer(url: url!)
               self.avPlayerViewController.player = self.avPlayer
             }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Initialize cell text labels to desired info
        myTextLabel.text = selectedLocation?.exerciseDescription
        
        //Dynamically size overview text field based on content
        myTextLabel.sizeToFit()
        myLabel.text = selectedLocation?.exerciseName
        
        //Dynamically size mind muscle connection text field based on content
        mindMuscleConnectionTextLabel.text = selectedLocation?.mmC
        mindMuscleConnectionTextLabel.sizeToFit()
    }
    
}
